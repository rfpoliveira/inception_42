FROM	debian:bullseye

EXPOSE	443

RUN		apt-get update && apt-get install -y --no-install-recommends --no-install-suggests \
		nginx \
		openssl && \
		rm -rf /var/lib/apt/lists/*

		#arguments to create the ssl certificate
ARG		CERT_FOLDER CERTIFICATE KEY COUNTRY STATE LOCALITY ORGANIZATION UNIT COMMON_NAME

# create the folder and the certificate
RUN 	mkdir -p ${CERT_FOLDER} && \
		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
    	-out ${CERT_FOLDER}/${CERTIFICATE} \
    	-keyout ${CERT_FOLDER}/${KEY} \
    	-subj "/C=${COUNTRY}/ST=${STATE}/L=${LOCALITY}/O=${ORGANIZATION}/OU=${UNIT}/CN=${COMMON_NAME}"

# copy nginx configs
COPY	conf/nginx.conf	/etc/nginx/
COPY	conf/server.conf	/etc/nginx/conf.d/

#making sure there is the webpage folder and user permisions
RUN     mkdir -p /var/www/html && \
        chown -R www-data:www-data /var/www/html

# run nginx
CMD		["nginx", "-g", "daemon off;"]