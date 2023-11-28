# Vérifie si le script est lancé avec les permissions administrateurs
echo "Vérification des permissions administrateurs..."
if [ $EUID -ne 0 ]; then
    echo "Vous devez lancer ce script avec les permissions administrateurs"
    exit 1
    else echo "Vous avez les permissions administrateurs"
fi

# Mise à jour des paquets et installation des dépendances
echo "Mise à jour des paquets et installation des dépendances..."
apt update && apt upgrade -y && apt install golang mysql-server apache2 zip curl -y


# Installation de GoPhish
echo "Installation de GoPhish..."
cd /opt
mkdir gophish
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
unzip gophish-v0.12.1-linux-64bit.zip -d /opt/gophish

# Création de la base de données
echo "Création de la base de données..."
mysql -u root -e "CREATE DATABASE gophish;"
mysql -u root -e "CREATE USER 'gophish'@'localhost' IDENTIFIED BY 'gophish';"
mysql -u root -e "GRANT ALL PRIVILEGES ON gophish.* TO 'gophish'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"

# Arrête le service d'Apache et le désactive
echo "Arrêt du service d'Apache et désactivation..."
systemctl stop apache2
systemctl mask apache2

# Question sur la configuration du serveur
echo "Veuillez entrer l'adresse IP de votre serveur d'Administration GoPhish :"
read ip_admin
echo "Veuillez entrer l'adresse IP de votre serveur de Phishing GoPhish :"
read ip_phish
echo "Voulez vous utiliser un certificat SSL pour votre serveur d'administration ? (y/n)"
read admin_ssl
if [ $admin_ssl = "y" ]; then
    admin_ssl_use=true
    echo "Voulez vous utiliser la configuration SSL par défaut ? (y/n)"
    read admin_ssl_default
    if [ $admin_ssl_default = "y" ]; then
        admin_cert="/opt/gophish/gophish_admin.crt"
        admin_key="/opt/gophish/gophish_admin.key"
        else
        echo "Veuillez entrer le chemin vers votre certificat SSL :"
        read admin_cert
        echo "Veuillez entrer le chemin vers votre clé SSL :"
        read admin_key
    fi
    else
    echo "Vous n'utiliserez pas de certificat SSL"
    admin_ssl_use=false
fi
echo "Voulez vous utiliser un certificat SSL pour votre serveur de phishing ? (y/n)"
read phish_ssl
if [ $ssl = "y" ]; then
    phish_ssl_use=true
    echo "Veuillez entrer le chemin vers votre certificat SSL :"
    read phish_cert
    echo "Veuillez entrer le chemin vers votre clé SSL :"
    read phish_key
    else
    echo "Vous n'utiliserez pas de certificat SSL"
    phish_ssl_use=false
fi
echo "Veuillez entrer une adresse mail de contact :"
read contact_mail

# Création du fichier de configuration
echo "Création du fichier de configuration..."
rm /opt/gophish/config.json
cd /opt/gophish
touch config.json
cat << EOF > config.json
{
    "admin_server": {
        "listen_url": "$ip_admin:3333",
        "use_tls": $admin_ssl_use,
        "cert_path": "$admin_cert",
        "key_path": "$admin_key",
        "trusted_origins": []
    },
    "phish_server": {
        "listen_url": "$ip_phish:80",
        "use_tls": $phish_ssl_use,
        "cert_path": "$phish_cert",
        "key_path": "$phish_key"
    },
    "db_name": "gophish",
    "db_path": "gophish.db",
    "migrations_prefix": "db/db_",
    "contact_address": "$contact_mail",
    "logging": {
        "filename": "gophish.log",
        "level": "error"
    }
}
EOF

# Met à jours les permissions du fichier de configuration
echo "Mise à jour des permissions du fichier de configuration..."
chmod 0640 /opt/gophish/config.json

# Démarrage de GoPhish
echo "Démarrage de GoPhish..."
echo "Note: Lors du premier démarrage, le nom d'utilisateur et le mot de passe seront indiqué dans les lignes suivantes."
echo "Une fois le mot de passe changé, faites ctrl + c pour arrêter GoPhish et continuer le script."
echo "Notez également que le serveur tournera en local. Vous devrez modifier le fichier config.json à votre guise par la suite."
cd /opt/gophish
chmod +x gophish
./gophish

# Création du service GoPhish
# echo "Création du service GoPhish..."
# cd /etc/systemd/system
# touch gophish.service
# echo "[Unit]" >> gophish.service
# echo "Description=GoPhish Service" >> gophish.service
# echo "After=network.target" >> gophish.service
# echo "" >> gophish.service
# echo "[Service]" >> gophish.service

echo "Installation de GoPhish terminée !"
echo "Pour lancer GoPhish, faites cd /opt/gophish puis ./gophish ."