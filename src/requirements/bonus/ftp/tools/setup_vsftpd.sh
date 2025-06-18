#!/bin/bash

set -x

FTP_USER_PASSWORD=$(cat /run/secrets/ftp_pw)
echo ${FTP_USER_PASSWORD}
echo ${FTP_USER}

# vsftpd needs the directory to start
mkdir -p /var/run/vsftpd/empty
chmod 755 /var/run/vsftpd/empty

# ls -ld /var/run/vsftpd/empty

# create secure chroot dir
mkdir -p /home/${FTP_USER}/ftp
chown root:root /home/${FTP_USER}/ftp
chmod a-w /home/${FTP_USER}/ftp

# ls -la /home/${FTP_USER}/ftp

# create user and set password
useradd -d /var/www/html -m ${FTP_USER}
echo "${FTP_USER}:${FTP_USER_PASSWORD}" | chpasswd #change to secrets and envs

#create ftp dirs
# mkdir -p /var/www/html
chmod +x /var/www/html
chown ${FTP_USER}:${FTP_USER} /var/www/html

# ls -la /var/www/html

echo "${FTP_USER}" | tee -a /etc/vsftpd.userlist

# cat /etc/vsftpd.userlist

# add ftp_user to www-data group so they share permissions
# give group read write and execute permissions and ownership
# makes it possible to download and upload files
usermod -aG www-data ${FTP_USER}
chmod -R g+rwX /var/www/html/${DOMAIN_NAME}
chgrp -R www-data /var/www/html/${DOMAIN_NAME}
chmod g+s /var/www/html/${DOMAIN_NAME}

exec vsftpd /etc/vsftpd/vsftpd.conf