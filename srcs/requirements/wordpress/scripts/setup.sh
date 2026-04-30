#!bin/bash

DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_PASSWORD=$(cat /run/secrets/wp_admin_password)
WP_USER_PASSWORD=$(cat /run/secrets/wp_user_password)

until mysqladmin ping -h"mariadb" --silent; do
    echo "Aguardando MariaDB..."
    sleep 2
done

if [ ! -f wp-config.php ]; then
    wp core download --allow-root
    wp config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_PASSWORD --dbhost=$DB_HOST --allow-root
    wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USER $WP_EMAIL --role=$WP_ROLE --user_pass=$WP_PASSWORD --allow-root
fi

chown -R www-data:www-data /var/www/html

exec "$@"