# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhuss <dhuss@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/20 11:50:06 by dhuss             #+#    #+#              #
#    Updated: 2025/06/20 11:50:07 by dhuss            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		mariadb-server \
	&& apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# change owensership to mysql so PID file can be stored inside
RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

# copy script
COPY ./tools/setup_mariadb.sh /setup_mariadb.sh

# config file of mariadb includes !includedir /etc/mysql/mariadb.conf.d/
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN chmod +x /setup_mariadb.sh
RUN chmod +x /etc/mysql/mariadb.conf.d/50-server.cnf

ENTRYPOINT ["./setup_mariadb.sh"]
