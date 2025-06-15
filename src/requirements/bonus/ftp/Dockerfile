# decide on FTP server
# -> vsftpd

# ftp requirements
# port 21 for control connections (commands)
# range of ports for passive data connections
# user and home directory for uploads

# TSL

# install ftp software
# dependencies

#user account and upload/download directories
# configure permissions and ownership

# https://wiki.debian.org/vsftpd

FROM debian:bookworm

RUN apt-get update && apt-get upgrade -y && \
	apt-getinstall -y \
		vsftpd