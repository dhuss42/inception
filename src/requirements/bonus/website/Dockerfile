FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y php

COPY /tools/* /var/www/html/

CMD ["php", "-S", "0.0.0.0:7777", "-t", "/var/www/html"]