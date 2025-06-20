# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhuss <dhuss@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/20 11:48:38 by dhuss             #+#    #+#              #
#    Updated: 2025/06/20 15:04:53 by dhuss            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
	apt-get install -y \
		vsftpd \
		net-tools \
	&& apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY /conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY /tools/setup_vsftpd.sh /setup_vsftpd.sh

RUN chmod +x setup_vsftpd.sh

ENTRYPOINT ["/setup_vsftpd.sh"]
