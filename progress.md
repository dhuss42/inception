# File to track progress for inception project and to list the next to dos

## To dos
	- merge note documents to one clearly structured overview
	- make a plan
		-> generate infrastructure
		-> make containers
		-> make volumes
		-> make docker compose
		-> makefile
		-> scripts
	- document scripts

#----bonus----#
	- Find defintitions for the identified unknown concepts in bonus part

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