#!/bin/bash

WP_PATH='/var/www/html/dhuss.42.fr/public_html'

GREEN='\033[0;32m'
WHITE='\033[1;37m'

BLUE='\[\033[0;34m\]'
RESET='\[\033[0m\]'

export PS4=${BLUE}'+ [DEBUG][${BASH_SOURCE##*/}:${LINENO}] '${RESET}
#force WP-Cli to use cat
export PAGER=cat
set -x

# Wait until mariadb is ready to accept connections
echo -e "${GREEN}waiting for mariadb to be ready...${WHITE}"
until mysqladmin ping -h mariadb --silent; do
    sleep 2
done
echo -e "${GREEN}mariadb is ready${WHITE}"

#create necessary directories and give permissions
mkdir -p /run/php
chown www-data:www-data /run/php

# giving permission for php config file, overwriting existingphp config file with new config for listening on 0.0.0.0:9000
chmod +x /www.conf
mv -f www.conf /etc/php/7.4/fpm/pool.d/

#get wp-cli

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#give rights and move
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# create directory structure for WordPress site, which nginx needs
mkdir -p ${WP_PATH}


# change ownership of the directory to the www-data user and group
# nginx runs under www-data user -> ownship ensures read/write files
chown -R www-data:www-data ${WP_PATH}
chmod -R 755 /var/www/html

# redundant
chown www-data:www-data ${WP_PATH}

# give permission for cache (solved all my issues)
mkdir -p /var/www/.wp-cli/cache
chown -R www-data:www-data /var/www/.wp-cli

# move into the directory for installing wordpress
# wp cli commands will be executed in the correct folder
cd ${WP_PATH}

# download wordpress
# Change the effective user ID and group ID to that of <user>
# -s: run <shell> if /etc/shells allows it
#  -c: pass a single command to the shell with -c

# if su -s /bin/sh www-data -c "wp core is-installed"; then
#     echo -e "${GREEN} Wordpress is already installed${WHITE}"
# else
    su -s /bin/sh www-data -c "wp core download &&  \
        wp core config --dbname=${DATABASE} \
                --dbuser=${WP_ADMIN} \
                --dbpass=${WP_ADMIN_PASSWORD} \
                --dbhost=${DB_HOST} && \
        wp core install --url=https://${DOMAIN_NAME} \
                --title='inception' \
                --admin_user=${WP_ADMIN} \
                --admin_password=${WP_ADMIN_PASSWORD} \
                --admin_email='${WP_ADMIN}@${DOMAIN_NAME}.com' \
                --skip-email"

        su -s /bin/sh www-data -c "wp user create ${WP_USER} ${WP_USER}@${DOMAIN_NAME} \
                --user_pass=${WP_USER_PASSWORD} \
                --porcelain"
        #could check if wp user exists ${WP_USER}
# fi
# Generate wp-config.php file.
# main configuration file for wordpress site



php-fpm7.4 -t

exec php-fpm7.4 -F