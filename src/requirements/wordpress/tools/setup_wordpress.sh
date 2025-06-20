#!/bin/bash

#------------------get secrets------------------#

DB_USER_PASSWORD=$(cat /run/secrets/db_pw)
WP_USER_PASSWORD=$(cat /run/secrets/wp_pw)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_pw)

GREEN='\033[0;32m'
WHITE='\033[1;37m'

#------------------wait for mariadb------------------#

# Wait until mariadb is ready to accept connections
until mysqladmin ping -h mariadb --silent; do
	sleep 2
done

#------------------configure php-fpm------------------#

#create necessary directories and give permissions
mkdir -p /run/php/php-fpm
chown www-data:www-data /run/php

# giving permission for php config file
# overwriting existing php config file with new config for listening on 0.0.0.0:9000
chmod +x /www.conf
mv -f www.conf /etc/php/7.4/fpm/pool.d/

#------------------setup wordpress client------------------#

#give rights and move
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

#------------------setup directory structure for wordpress------------------#

WP_PATH=/var/www/html/${DOMAIN_NAME}/public_html

# create directory structure for WordPress site, which nginx needs
mkdir -p ${WP_PATH}
mkdir -p /var/www/.wp-cli/cache
chown -R www-data:www-data /var/www/
chmod -R 755 /var/www/html

#------------------configure wordpress------------------#

# move into the directory for installing wordpress
# wp cli commands will be executed in the correct folder
cd ${WP_PATH}

# download wordpress
# Change the effective user ID and group ID to that of www-data
# -s: run <shell> if /etc/shells allows it
#  -c: pass a single command to the shell with -c
if [ ! -f "${WP_PATH}/wp-load.php" ]; then
		su -s /bin/sh www-data -c "wp core download"
fi

if [ ! -f "${WP_PATH}/wp-config.php" ]; then
		su -s /bin/sh www-data -c "wp core config \
				--dbname=${DATABASE} \
				--dbuser=${DB_USER} \
				--dbpass=${DB_USER_PASSWORD} \
				--dbhost=${DB_HOST}"
fi

if ! su -s /bin/sh www-data -c "wp core is-installed"; then
		su -s /bin/sh www-data -c "wp core install \
				--url=https://${DOMAIN_NAME} \
				--title='inception' \
				--admin_user=${WP_ADMIN} \
				--admin_password=${WP_ADMIN_PASSWORD} \
				--admin_email="${WP_ADMIN}@${DOMAIN_NAME}.com" \
				--skip-email"
fi

if ! su -s /bin/sh www-data -c "wp user exists ${WP_USER}"; then
		su -s /bin/sh www-data -c "wp user create ${WP_USER} ${WP_USER}@${DOMAIN_NAME}.com \
				--user_pass=${WP_USER_PASSWORD} \
				--porcelain"
fi

#------------------configure wordpress themes------------------#

if ! su -s /bin/sh www-data -c "wp theme is-installed vitrum"; then
		su -s /bin/sh www-data -c "wp theme install vitrum"
fi

if ! su -s /bin/sh www-data -c "wp theme is-active vitrum"; then
		su -s /bin/sh www-data -c "wp theme activate vitrum"
fi

#------------------redis-cache------------------#

if ! su -s /bin/sh www-data -c "wp plugin is-installed redis-cache"; then
		su -s /bin/sh www-data -c "wp plugin install redis-cache"
fi

if ! su -s /bin/sh www-data -c "wp plugin is-active redis-cache"; then
		su -s /bin/sh www-data -c "wp plugin activate redis-cache"
fi

su -s /bin/sh www-data -c "wp config set WP_REDIS_HOST redis && \
		wp config set WP_REDIS_PORT 6379 && \
		wp config set WP_REDIS_MAXTTL 604800"

su -s /bin/sh www-data -c "wp redis enable"

exec php-fpm7.4 -F