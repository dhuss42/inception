# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhuss <dhuss@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/20 11:49:23 by dhuss             #+#    #+#              #
#    Updated: 2025/06/20 15:04:26 by dhuss            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y php \
	&& apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY /tools/* /var/www/html/

#execute php with (-S) built in web-server that listens on all interfaces on port 7777 at the document root from which the files will be served
CMD ["php", "-S", "0.0.0.0:7777", "-t", "/var/www/html"]