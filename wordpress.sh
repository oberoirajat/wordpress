#!/bin/bash

sudo apt-get -y update

logger "Installing WordPress"

# Set up a silent install of MySQL
dbpass=$1

export DEBIAN_FRONTEND=noninteractive
sduo echo mysql-server-5.6 mysql-server/root_password password $dbpass | debconf-set-selections
sudo echo mysql-server-5.6 mysql-server/root_password_again password $dbpass | debconf-set-selections

# Install the LAMP stack and WordPress
sudo apt-get -y install apache2 mysql-server php5 php5-mysql wordpress

# Setup WordPress
sudo gzip -d /usr/share/doc/wordpress/examples/setup-mysql.gz
bash /usr/share/doc/wordpress/examples/setup-mysql -n wordpress localhost

ln -s /usr/share/wordpress /var/www/html/wordpress
sudo mv /etc/wordpress/config-localhost.php /etc/wordpress/config-default.php

# Restart Apache
sudo apachectl restart

logger "Done installing WordPress; open /wordpress to configure"