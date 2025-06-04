#!/bin/bash

# for debugging prints all cmds
set -x

mysqld_safe &

# Wait until MariaDB is ready to accept connections
echo "Waiting for MariaDB to be ready..."
until mysqladmin ping --silent; do
    sleep 1
done

# -u root: run mysql as user root
# -e : execute the cmd inside quotes
# use password passed through envs
mysql -u root -e "SET PASSWORD FOR 'root'@'localhost' = PASSWORD('${MYSQL_ROOT_PASSWORD}');"

# execute command as root using heredoc
mysql -u root -p"${MYSQL_ROOT_PASSWORD}" <<EOF
CREATE DATABASE IF NOT EXISTS ${DATABASE};
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${DATABASE}.* TO ${MYSQL_USER};
FLUSH PRIVILEGES;
EOF

# wait so that container does not shut down
wait
