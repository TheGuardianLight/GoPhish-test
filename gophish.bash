# Vérifie si le script est lancé avec les permissions administrateurs
if [ $EUID -ne 0 ]; then
    echo "Vous devez lancer ce script avec les permissions administrateurs"
    exit 1
fi

# Mise à jour des paquets
apt update && apt upgrade -y

# Installation de Go
apt install golang -y

# Installation de GoPhish
cd /var/www
mkdir gophish
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
unzip gophish-v0.12.1-linux-64bit.zip

# Installation de MySQL
apt install mysql-server -y

# Création de la base de données
mysql -u root -e "CREATE DATABASE gophish;"
mysql -u root -e "CREATE USER 'gophish'@'localhost' IDENTIFIED BY 'gophish';"
mysql -u root -e "GRANT ALL PRIVILEGES ON gophish.* TO 'gophish'@'localhost';"
mysql -u root -e "FLUSH PRIVILEGES;"
mysql -u root -e "EXIT;"

# Configuration de GoPhish
cd /var/www/gophish
./gophish --hostname
./gophish --listenphish
./gophish --listenadmin
./gophish --dbpath /var/www/gophish/gophish.db --createdb
./gophish --adminport 3333 --adminlisten
./gophish --admin
./gophish --admin --username admin --password admin --listenadmin
./gophish --admin --username admin --password admin --listenadmin --listenphish
./gophish --admin --username admin --password admin --listenadmin --listenphish --dbpath /var/www/gophish/gophish.db --createdb
./gophish --admin --username admin --password admin --listenadmin --listenphish --dbpath /var/www/gophish/gophish.db --createdb --hostname

# Création du service GoPhish
cd /etc/systemd/system
touch gophish.service
echo "[Unit]" >> gophish.service
echo "Description=GoPhish Service" >> gophish.service
echo "After=network.target" >> gophish.service
echo "" >> gophish.service
echo "[Service]" >> gophish.service

