FROM debian:bullseye

#adminer is a single php file needs php to execute and php-mysqli to talk to mariadb
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		php \
		php-mysqli \
		curl

# -L follows redirects; -o saves the downloaded file as /var/www/html/index.php
RUN mkdir -p /var/www/html && \
    curl -L -o /var/www/html/index.php https://www.adminer.org/latest.php

# Expose port 8080 for accessing Adminer via the browser
EXPOSE 8080

#execute php with (-S) built in web-server that listens on all interfaces on port 8080 at the document root from which the files will be served
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]