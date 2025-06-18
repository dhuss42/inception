# File to track progress for inception project and to list the next to dos

## To dos
	[] change domain name
	[] virtual machine on 42 machine
	[x] change to expected file system
	[x] credentials, API keys and passwords musst be stored locally and ignored by git
	[x] wordpress download, config and installtion should check wether it has been installed already
	[x] second user for admin (no admin in name or credentials)
	[x] read up on wait with mariadb
	[x] check ports in docker-compose
	[] update documentation
	[] handle exit codes adminer, portainer (2), website, ftp
	[] clean up at end
		[] Debugging messages
		[] echo secrets in scripts
		[] set -x

#----bonus----#
	- Find defintitions for the identified unknown concepts in bonus part
		[x] adminer
		[x] redis chache
		[x] FTP server
		[x] service of choice -> Portainer
		[x] static website


## ======Day 1======
	-> went through subject and identified unknown concepts (see notes)
	-> eval point +1
	-> watched a 1:49:49h Docker Tutorial and took notes
		https://www.youtube.com/watch?v=3c-iBn73dDE

## ======Day 2======
	-> installed Docker on Mac at home
	-> finished watching the Docker Tutorial
	-> completed a short beginner Tutorial on docker docs
	-> wrote a test dockerfile and docker-compose and built a container with debian OS and c++, make, valgrind
	-> filled out more of the unknown concepts
		-> tsl
		-> nginx
		-> mariaDB
		-> PID 1
		-> daemons
		-> API
		-> best practices for dockerfiles
	-> started with mariaDB dockerfile

## ======Day 3======
	-> read a little about docker-compose
	-> played around with Makefile
	-> played around with docker-compose
	-> built dockerfiles for wordpress an nginx
	-> tried to figure out config for nginx
		-> TSL
			https://www.cyberciti.biz/faq/configure-nginx-to-use-only-tls-1-2-and-1-3/
		-> config
			https://www.andrewhoog.com/post/how-to-customize-nginx-config-in-a-docker-image/
		-> script
		-> certificate and key
			https://www.youtube.com/watch?v=X3Pr5VATOyA
			https://www.digitalocean.com/community/tutorials/how-to-create-a-self-signed-ssl-certificate-for-nginx-on-debian-10

## ======Day 4======
	-> read more on ngnix
		https://nginx.org/en/docs/beginners_guide.html
	-> managed to set up TSL (I think)
		-> openssl.cnf to automate prompts during key gen
	-> proper copying and running of files and script
	-> Learning more configuration for nginx
		https://www.youtube.com/watch?v=C5kMgshNc6g

## ======Day 5======
	-> working nginx version for now
		-> set up the root and index page and can access it via https://localhost/
	-> config documentation for nginx
		https://nginx.org/en/docs/http/request_processing.html
	-> trying to set up wordpress
		https://www.youtube.com/watch?v=gEceSAJI_3s
		https://www.linode.com/docs/guides/how-to-install-wordpress-using-wp-cli-on-debian-10/#download-and-configure-wordpress
	-> also working on mariadb configuration
		-> probably makes more sense to finish it before doing the wordpress config
	-> located the mariadb 50-server.cnf file extracted it to modify it now
	-> worked on the mariadb script
		-> now the environment variables are used to create a user and a databse

## ======Day 6======
	-> worked on Makefile
		-> clean
		-> fclean
		-> updated status to show disk usage
		-> up: added flags for navigating to compose file, adding envs and naming project, also starting in detached mode (for terminal), and building images before starting containers
		-> down, stop, start, restart
	-> worked on wordpress script
		-> fixed automatic restarting
		-> script now waits until mariadbis setup
		-> followed installation guid o wordpress config
	-> changed bind address inside mariadb config to 0.0.0.0 now it allows listens on all interfaces
	-> finished wordpress configuration
	-> setting up nginx & php-fpm communication
		-> nginx config file handles incoming php requests and sends them to php-fpm
		-> php-fpm listens on correct port to handle incoming requests passed on by ngin

## ======Day 6======
	-> created custom config for the communication between nginx and php-fpm
		-> passing through dockerfile and overwriting the default config
	-> did some cleaning up
	-> solves issue with only html appearing
		-> had to create directories inside wp script for wp_cli cache and give rights
	-> created user on start

## ======Day 7======
	-> changed to expected file system
	-> worked on secrets
		https://docs.docker.com/compose/how-tos/use-secrets/
		secrets are now used for passwords and ignored as are .env
	-> for some reason I don't get correctly installed wordpress any more :(

## ======Day 8======
	-> struggling to find the solution
		-> mariadb wordpress communication seems to work
		-> php-fpm nginx communication seems to work
	-> added healthcheck so that nginx service starts after wordpress

## ======Day 9======
	-> found out I am an idiot
		page was working all the time

## ======Day 10======
	- added themes in wordpress setup
		https://developer.wordpress.org/cli/commands/
	- did some cleaning up in wordpress script && Dockerfiles
	- included checks in wordpress script to avoid error messages and unncessary installs
	- got adminer to work
		- need to login via http:://localhost:8080
			- server name mariadb

## ======Day 11======
	- reading upon redis-cache
		- Docker
			https://www.docker.com/blog/how-to-use-the-redis-docker-official-image/
		- config
			https://github.com/redis/redis/blob/unstable/redis.conf
		- redis cli
			https://redis.io/docs/latest/develop/reference/client-side-caching/
		- redis-cache wordpress plugin
			https://wordpress.org/plugins/redis-cache/
		- configuration of redis-cache plugin
			https://github.com/rhubarbgroup/redis-cache/#configuration
			https://github.com/rhubarbgroup/redis-cache/blob/develop/INSTALL.md
			https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
	- managed redis-cache setup
	- added static website container
		-> accessable via localhost:7777
		-> still needs basic desgin
			-> following this guide for html and css
			https://www.youtube.com/watch?v=FHb9JobDs2o
				-> 13:32

## ======Day 12======
	-> finished static website
	-> set up reverse proxy for static website and adminer
		-> now accessable via localhost/adminer & localhost/resume
	-> removed exposed ports and access from host on these ports in docker-compose
	-> looked up vsftpd for debian
		https://wiki.debian.org/vsftpd
		https://reintech.io/blog/configure-secure-ftp-server-vsftpd-debian-12

	-> config documentation
		http://vsftpd.beasts.org/vsftpd_conf.html

## ======Day 13======
	-> started setting up vsftpd
		https://www.digitalocean.com/community/tutorials/how-to-set-up-vsftpd-for-a-user-s-directory-on-ubuntu-20-04
		https://docs.digitalocean.com/products/droplets/how-to/transfer-files/#install-filezilla
	-> started setting up portainer
		https://www.youtube.com/watch?v=WGf-bCiW1Q0
		https://docs.portainer.io/start/install/server/docker/linux

## ======Day 14======
	-> set up portainer
	-> Problem: when running make stop portainer exits with 2 and nginx, mariadb, website and adminer with 127
		-> fixed for nginx (didn't use exec nginx) 
			-> sigterm goes to the script not nginx directly when starting nginx without exec (because it is a child process)
		-> changed mariadb setup to init mariadbd + shutdown and start mariadbd

## ======Day 15======
	-> set up ftp
		-> added nginx_wordpress volume
		-> added env and pw with secrets
		-> tested with filezilla
		-> handled permission issues so that ftp_user can upload and download files in volume
		-> new files still need permission rights so that nginx can open say an html site