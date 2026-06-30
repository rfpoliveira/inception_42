FROM debian:bullseye

# default port for mariadb
EXPOSE 3306 

# install mariadb and clear cache
RUN		apt-get update && \
		apt-get install -y --no-install-recommends --no-install-suggests \
		mariadb-server && \
		rm -rf /var/lib/apt/lists/*

#create mysql diretory and give permissions
RUN mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

#copies the configuration
COPY	conf/50-server.cnf /etc/mysql/mariadb.conf.d/

#copy and give permision to execute the script
COPY	scripts/setup.sh /bin/
RUN		chmod +x /bin/setup.sh

# define the script as the default to startup
ENTRYPOINT	["/bin/setup.sh"]