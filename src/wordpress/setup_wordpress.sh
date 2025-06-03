#!/bin/bash

# RED=\033[0;31m
GREEN='\033[0;32m'
# YELLOW=\033[0;33m
BLUE='\[\033[0;34m\]'
# MAGENTA=\033[0;35m
# CYAN=\033[0;36m
WHITE='\033[1;37m'
RESET='\[\033[0m\]'

export PS4=${BLUE}'+ [DEBUG][${BASH_SOURCE##*/}:${LINENO}] '${RESET}
set -x

# Wait until mariadb is ready to accept connections
echo -e "${GREEN}waiting for mariadb to be ready...${WHITE}"
until mysqladmin ping -h mariadb --silent; do
    sleep 2
done
echo -e "${GREEN}mariadb is ready${WHITE}"

which php-fpm

#create necessary directories and give permissions
mkdir -p /run/php
chown www-data:www-data /run/php


#get wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#give rights and move
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# create WordPress site's document root
mkdir -p /var/www/html/dhuss.42.fr/public_html

#
chown -R www-data:www-data /var/www/html/dhuss.42.fr/public_html

#
chown www-data:www-data /var/www/html/dhuss.42.fr/public_html

cd /var/www/html/dhuss.42.fr/public_html
# sudo -u www-data wp core download

# sudo -u www-data wp core config --dbname=${MYSQL_DATABASE} --dbuser=${MYSQL_USER} --dbpass=${MYSQL_PASSWORD}

exec php-fpm7.4 -F