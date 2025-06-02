#!/bin/bash

# RED=\033[0;31m
# GREEN=\033[0;32m
# YELLOW=\033[0;33m
BLUE='\[\033[0;34m\]'
# MAGENTA=\033[0;35m
# CYAN=\033[0;36m
WHITE='\[\033[1;37m\]'
RESET='\[\033[0m\]'

export PS4=${BLUE}'+ [DEBUG][${BASH_SOURCE##*/}:${LINENO}] '${RESET}
set -x

which php-fpm

#create necessary directories and give permissions
mkdir -p /run/php
chown www-data:www-data /run/php

#start php-fpm
php-fpm7.4 &

#get wp-cli
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

#give rights and move
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

