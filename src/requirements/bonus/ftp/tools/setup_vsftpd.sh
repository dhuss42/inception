#!/bin/bash

set -x

#create secure chroot dir
mkdir -p /home/ftpuser/ftp
# chown
chmod a-w /home/ftpuser/ftp

ls -la /home/ftpuser/ftp

# create user and set password
useradd -m ftpuser
passwd ftpuser
echo "ftpuser:ftpuser" | chpasswd #change to secrets and envs

#create ftp dirs
mkdir -p /home/ftpuser/ftp/files
chown ftpuser:ftpuser /home/ftpuser/ftp/files

ls -la /home/ftpuser/ftp

echo "vsftpd test file" | tee /home/ftpuser/ftp/files/test.txt

echo "ftpuser" | tee -a /etc/vsftpd.userlist

cat /etc/vsftpd.userlist

exec vsftpd /etc/vsftpd.conf