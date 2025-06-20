# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhuss <dhuss@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/20 11:47:55 by dhuss             #+#    #+#              #
#    Updated: 2025/06/20 15:05:34 by dhuss            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

#adminer is a single php file needs php to execute and php-mysqli to talk to mariadb
RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		php \
		php-mysqli \
		curl \
	&& apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# -L follows redirects; -o saves the downloaded file as /var/www/html/index.php
RUN mkdir -p /var/www/html && \
	curl -L -o /var/www/html/index.php https://www.adminer.org/latest.php

#execute php with (-S) built in web-server that listens on all interfaces on port 8080 at the document root from which the files will be served
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/var/www/html"]