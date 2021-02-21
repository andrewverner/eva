#!/usr/bin/env bash
echoTitle () {
    echo -e "\033[0;30m\033[42m -- $1 -- \033[0m"
}

# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Virtual Machine Setup'
# ---------------------------------------------------------------------------------------------------------------------
sudo apt-get update -qq
sudo apt-get -y install git curl nano composer

# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'MYSQL-Database'
# ---------------------------------------------------------------------------------------------------------------------
# Setting MySQL (username: root) ~ (password: password)
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password password'
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password password'
# Installing packages
sudo apt-get install -y mysql-server

# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Installing PHP'
# ---------------------------------------------------------------------------------------------------------------------
sudo apt-get update -qq
sudo apt -y install software-properties-common
sudo add-apt-repository ppa:ondrej/php
sudo apt-get update -qq
sudo apt-get -y install php7.4-{amqp,bcmath,cgi,cli,common,curl,dev,fpm,gd,intl,json,mbstring,mysql,tidy,xdebug,xml,xmlrpc,zip}

# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Creating YII2 basic project'
# ---------------------------------------------------------------------------------------------------------------------
cd /var/www/html
composer create-project --prefer-dist yiisoft/yii2-app-basic eva

# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Setting up a project'
# ---------------------------------------------------------------------------------------------------------------------
git init
git remote add origin https://github.com/andrewverner/eva.git
git fetch origin
git reset --hard origin/master

# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'Installing NGINX'
# ---------------------------------------------------------------------------------------------------------------------
sudo apt-get install -y nginx
sudo touch /var/log/nginx/eva.error.log
sudo touch /var/log/nginx/eva.access.log
sudo cp /var/www/html/vagrant/app.conf /etc/nginx/sites-enabled/app.conf
sudo service nginx restart

# ---------------------------------------------------------------------------------------------------------------------
echoTitle 'DONE. Do not forget to add 192.168.100.70 eva.local into hosts file'
# ---------------------------------------------------------------------------------------------------------------------
