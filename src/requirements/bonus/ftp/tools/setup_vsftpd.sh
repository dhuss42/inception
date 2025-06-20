#!/bin/bash

#------------------get secrets------------------#

FTP_USER_PASSWORD=$(cat /run/secrets/ftp_pw)

# vsftpd needs the directory to start
mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

# create secure chroot dir
mkdir -p /home/${FTP_USER}/ftp
chown root:root /home/${FTP_USER}/ftp
chmod 755 /home/${FTP_USER}/ftp


# create user and set password
useradd -d /home/${FTP_USER}/ftp -m ${FTP_USER}
echo "${FTP_USER}:${FTP_USER_PASSWORD}" | chpasswd

#create symbolic link between directories
ln -s /var/www/html /home/${FTP_USER}/ftp/webroot

#create ftp dirs
mkdir -p /var/www/html
chmod 775 /var/www/html

echo "${FTP_USER}" | tee -a /etc/vsftpd.userlist

#------------------handle user permissions------------------#

# add ftp_user to www-data group so they share permissions
# give group read write and execute permissions and ownership
# makes it possible to download and upload files
usermod -aG www-data ${FTP_USER}
chmod -R g+rwX /var/www/html/
chgrp -R www-data /var/www/html/
chmod 2775 /var/www/html/

#------------------execute vsftpd------------------#

exec vsftpd /etc/vsftpd/vsftpd.conf