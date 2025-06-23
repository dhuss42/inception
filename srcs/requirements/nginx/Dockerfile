# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhuss <dhuss@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/20 11:50:16 by dhuss             #+#    #+#              #
#    Updated: 2025/06/20 11:50:16 by dhuss            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		nginx \
		openssl \
	&& apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# copy this file into conf.d because the main nginx config file has "include /etc/nginx/conf.d/*.conf;"
# any valid config file with a server block will run
COPY ./conf/custom.conf	/etc/nginx/conf.d/custom.conf

COPY ./conf/openssl.cnf /etc/nginx/ssl/openssl.cnf
COPY ./tools/setup_nginx.sh /setup_nginx.sh

# grant rights to execute script & use openssl.cnf for automatic prompt answering during key gen
RUN chmod +x /setup_nginx.sh
RUN chmod +x /etc/nginx/ssl/openssl.cnf

ENTRYPOINT ["/setup_nginx.sh"]