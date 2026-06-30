#!/bin/bash
set -e # makes the script stop if any fail

DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)
DB_PASSWORD=$(cat /run/secrets/db_password)

if [! -d "/var/lib/mysql/mysql" ]; then
	echo "First execution: mariadb"
	mysqld_safe --skip-networking > /dev/null 2>&1 & # launch mariadb in backgorund, skip network while root is being configured

	until mysqladmin ping --silent 2>/dev/null; do
    		sleep 1
	done # waiting to mariadb to launch

	mysql -u root --skip-password -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
	mysql -u root --skip-password -e "CREATE USER IF NOT EXISTS \`${DB_USER}\`@'%' IDENTIFIED BY '${DB_PASSWORD}';"
	mysql -u root --skip-password -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO \`${DB_USER}\`@'%';"
	mysql -u root --skip-password -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${DB_ROOT_PASSWORD}';"
	mysql -u root --skip-password -e "FLUSH PRIVILEGES;"

	mysqladmin -u root --skip-password shutdown # shutdown background
	echo "first configuration done"
else
	echo "mariadb already inicialized, skipping configuration"
fi

exec mysqld_safe # launch
