FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		php-fpm \
		php-mysqli \
		curl \
		mariadb-client \
	&& apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY	./tools/setup_wordpress.sh /setup_wordpress.sh
RUN		chmod +x /setup_wordpress.sh

COPY	./conf/www.conf /www.conf

ENTRYPOINT ["/setup_wordpress.sh"]