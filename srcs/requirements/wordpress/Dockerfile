FROM debian:bullseye

EXPOSE 9000

RUN		apt-get update && apt-get install --no-install-recommends --no-install-suggests -y \
		ca-certificates \
		php-fpm \
		php-mysql \
		php-curl \
		php-gd \
		php-mbstring \
		mariadb-client \
		wget && \
		rm -rf /var/lib/apt/lists/*

RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php /var/www/html
RUN chown -R www-data:www-data /var/www/html

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY conf/wp-config.php /tmp/wp-config.php
	
COPY scripts/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD ["/usr/sbin/php-fpm7.4", "--nodaemonize"]