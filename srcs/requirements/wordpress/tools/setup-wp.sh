#!/bin/sh
set -e

# Load secrets
DB_PASSWORD=$(cat "${MYSQL_PASSWORD_FILE}")
WP_ADMIN_PASSWORD=$(cat "${WP_ADMIN_PASSWORD_FILE}")
WP_USER_PASSWORD=$(cat "${WP_USER_PASSWORD_FILE}")


chown -R www-data:www-data /var/www/html/

if [ ! -f /var/www/html/wp-config.php ]; then
    echo "Setting up WordPress..."
    wp core download --allow-root || true

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost=mariadb:3306 \
        --allow-root

    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --allow-root

    wp user create \
        "${WP_USER}" \
        "${WP_USER_EMAIL}" \
        --role=author \
        --user_pass="${WP_USER_PASSWORD}" \
        --allow-root
    
    # echo "WordPress installation complete!"
# else
#     echo "WordPress already configured, skipping setup..."
fi

mkdir -p /run/php
chown -R www-data:www-data /run/php

exec /usr/sbin/php-fpm7.4 -F --nodaemonize