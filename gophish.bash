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

# Met à jours les permissions du fichier de configuration
echo "Mise à jour des permissions du fichier de configuration..."
chmod 0640 /opt/gophish/config.json

# Démarrage de GoPhish
echo "Démarrage de GoPhish..."
cd /opt/gophish
chmod +x gophish
./gophish

# Vérifie que GoPhish est lancé
echo "Vérification que GoPhish est lancé..."
netstat -al | grep 3333
curl http://localhost:3333

# Création du service GoPhish
echo "Création du service GoPhish..."
cd /etc/systemd/system
touch gophish.service
echo "[Unit]" >> gophish.service
echo "Description=GoPhish Service" >> gophish.service
echo "After=network.target" >> gophish.service
echo "" >> gophish.service
echo "[Service]" >> gophish.service

echo "Installation terminée !"