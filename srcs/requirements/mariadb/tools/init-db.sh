#!/bin/sh
set -e

sed -i 's/^bind-address.*/bind-address = 0.0.0.0/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/^skip-networking/#skip-networking/' /etc/mysql/mariadb.conf.d/50-server.cnf
sed -i 's/^skip-name-resolve/#skip-name-resolve/' /etc/mysql/mariadb.conf.d/50-server.cnf

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
    service mariadb start
    sleep 3

mysql -u root -p"${MYSQL_ROOT_PASSWORD}"  <<-EOF
CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '$(cat $MYSQL_PASSWORD_FILE)';
GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
echo "Database and user created."
    mysqladmin -u root -p"${MYSQL_ROOT_PASSWORD}" shutdown
    sleep 1
    echo "Database initialized."
fi

exec mysqld_safe --user=mysql