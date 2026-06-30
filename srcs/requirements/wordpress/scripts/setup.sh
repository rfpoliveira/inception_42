#!/bin/bash
set -e

cd /var/www/html

DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

RETRIES=30
until mysqladmin ping -h"mariadb" --silent 2>/dev/null; do
    RETRIES=$((RETRIES - 1))
    if [ $RETRIES -eq 0 ]; then
        echo "MariaDB did not respond in time, exiting..."
        exit 1
    fi
    echo "Waiting MariaDB... ($RETRIES attempts remaining)"
    sleep 2
done

if [ ! -f index.php ]; then
    echo "WordPress not found, installing..."

    wp core download --allow-root --locale=en_US

    if [ -f /tmp/wp-config.php ]; then
        cp /tmp/wp-config.php /var/www/html/wp-config.php
    fi

    wp core install \
        --url="$WP_FULL_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --skip-email \
        --allow-root

    wp user create "$WP_USER" "$WP_EMAIL" \
        --role="$WP_ROLE" \
        --user_pass="$WP_USER_PASSWORD" \
        --allow-root

    echo "WordPress installed successfully"
else
    echo "WordPress already installed"
fi

chown -R www-data:www-data /var/www/html

exec "$@"