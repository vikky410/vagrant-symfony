#!/bin/bash

echo "Provisioning virtual machine..."
apt-get update > /dev/null 2>&1

echo "Installing Git..."
apt-get install git -y > /dev/null 2>&1

 echo "Installing Nginx..."
 apt-get install nginx -y > /dev/null

 echo "Updating PHP repository..."
 apt-get install python-software-properties build-essential -y > /dev/null
    add-apt-repository ppa:ondrej/php5 -y > /dev/null 2>&1
    apt-get update > /dev/nul

 echo "Installing PHP..."
 apt-get install php5-common php5-dev php5-cli php5-fpm -y > /dev/null 2>&1

 echo "Installing PHP extensions..."
 apt-get install curl php5-curl php5-gd php5-mcrypt php5-mysql -y > /dev/null 2>&1

 echo "Preparing mySQL..."
 apt-get install debconf-utils -y > /dev/null 2>&1
 debconf-set-selections <<< "mysql-server mysql-server/root_password password 1234"
 debconf-set-selections <<< "mysql-server mysql-server/root_password_again password 1234"
 apt-get install mysql-server -y > /dev/null 2>&1

 echo "Installing Composer..."
 curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer


 echo "Installing Node..."
 dpkg -s npm &>/dev/null 2>&1 || {
    apt-get -y install nodejs npm
    ln -s /usr/bin/nodejs /usr/bin/node
  }

 echo "Installing bower.." 
 npm install -g bower > /dev/null 2>&1

 echo "Installing gulp.." 
 npm install --g gulp-cli > /dev/null 2>&1

echo "Config PHP Timezone & FPM Fix Path"
echo "date.timezone = UTC" >> /etc/php5/fpm/php.ini
echo "date.timezone = UTC" >> /etc/php5/cli/php.ini

echo "cgi.fix_pathinfo=0" >> /etc/php5/fpm/php.ini


echo "Config Nginx"
sudo cp /vagrant/vagrant-config/nginx-config/symfony_nginx /etc/nginx/sites-available/symfony > /dev/null 2>&1
#sudo cp /vagrant/vagrant-config/nginx-config/wordpress_nginx /etc/nginx/sites-available/wordpress > /dev/null 2>&1
sudo rm /etc/nginx/sites-available/default > /dev/null 2>&1
sudo rm /etc/nginx/sites-enabled/default > /dev/null 2>&1

