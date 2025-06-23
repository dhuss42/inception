#!/bin/bash

#------------------get secrets------------------#

DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_pw)
DB_USER_PASSWORD=$(cat /run/secrets/db_pw)

#------------------init mariadb------------------#

mariadbd --skip-networking &

until mysqladmin ping --silent; do
	sleep 1
done

# -u root: run mysql as user root
# -e : execute the cmd inside quotes
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');"

# execute command as root using heredoc
mysql -u root -p"${DB_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${DATABASE};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

mysqladmin -u root shutdown

#------------------execute mariadb------------------#

# run mariadbd as pid1
exec mariadbd