FROM debian:bullseye

EXPOSE 9000

ARG	PHPPATH=/etc/php/7.4/fpm

RUN		apt update && apt install --no-install-recommends --no-install-suggests -y \
		ca-certificates \
		php7.4-fpm \
		php7.4-mysql \
		mariadb-client
		wget \
		tar && \
		rm -rf /var/lib/apt/lists/*

RUN	    wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
        chmod +x wp-cli.phar && \
        mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /run/php /var/www/html
RUN chown -R www-data:www-data /var/www/html

COPY conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
COPY scripts/setup.sh /usr/local/bin/setup.sh
RUN chmod +x /usr/local/bin/setup.sh

WORKDIR /var/www/html

ENTRYPOINT ["/usr/local/bin/setup.sh"]

CMD ["/usr/sbin/php-fpm7.4", "--nodaemonize"]