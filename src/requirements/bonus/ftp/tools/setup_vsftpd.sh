#!/bin/bash

#------------------get secrets------------------#

FTP_USER_PASSWORD=$(cat /run/secrets/ftp_pw)

#------------------vsftpd runtime directory------------------#
mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

#------------------create FTP_USER------------------#

# create user and set password
useradd -d /var/www/html -m ${FTP_USER}
echo "${FTP_USER}:${FTP_USER_PASSWORD}" | chpasswd

#------------------permissions------------------#
echo "${FTP_USER}" | tee -a /etc/vsftpd.userlist

# FTP_USER can write to the wordpress volume
usermod -aG www-data ${FTP_USER}
chmod -R 2775 /var/www/html/
chown -R www-data /var/www/html
cmod g+s /var/www/html

#------------------permissions------------------#
echo "FTP test file" > /var/www/html/ftp_test.txt

#------------------execute vsftpd------------------#

exec vsftpd /etc/vsftpd/vsftpd.conf