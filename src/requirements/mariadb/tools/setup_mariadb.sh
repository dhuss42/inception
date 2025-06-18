#!/bin/bash

DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_pw)
DB_USER_PASSWORD=$(cat /run/secrets/db_pw)

echo "[DB_ROOT_PASSWORD] = ${DB_ROOT_PASSWORD}"
echo "[DB_USER_PASSWORD] = ${DB_USER_PASSWORD}"

# for debugging prints all cmds
set -x

# run mariadbd (server deamon) in background
mariadbd --skip-networking &

# Wait until MariaDB is ready to accept connections
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping --silent; do
    sleep 1
done

# -u root: run mysql as user root
# -e : execute the cmd inside quotes
# use password passed through envs
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${DB_ROOT_PASSWORD}');"

# execute command as root using heredoc
mysql -u root -p"${DB_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${DATABASE};
CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE}.* TO '${DB_USER}'@'%';
FLUSH PRIVILEGES;
EOF

# sends shutdown signal to mariadbd server
mysqladmin -u root shutdown

# run mariadbd as pid1
exec mariadbd
