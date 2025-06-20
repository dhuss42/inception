## Contents

## Short Description of Project and Task

- Web Host Docker Stack run inside a virtual machine
- Docker images have to be built using docker-compose.yml
- containers musst be built from penultimate stable version of Alpine or Debian
	- debian:bookworm
- Write own Dockerfiles


## Mandatory Part
- nginx
	- TSLv1.2/v1.3
- wordpress
	- php-fpm
	- wordpress musst be installed and configured
	- volume that contains WordPress files (also mounted to nginx container)
- mariadb
	- database Management System
		-> software that controls the database
	- Database
		-> collection of related files
	- volume that contains WordPress database
- docker-network
	- 

## Bonus
Each additional service runs inside its own container
- ftp
	- pointing to the volume of the WordPress website
- adminer
- redis-cache for wordpress
			- redis cache for Wordpress
			- A cache is a hardware or software component that stores data so that future requests for that data can be served faster; the data stored in a cache might be the result of an earlier computation or a copy of data stored elsewhere
			- a non-sql database
			- stores data in key=value pairs
			- works in ram -> that's why used for caching
			- built on top of a tradtional database and redis sits infront of it
			- a redis database for caching
				- between webserver and databases
				- if request is in cache it can be accessed from there directly saving response time
				- if its not in cache it goes to database and is then stored in cache
			- downside is cache staleness, meaning it does not represent the up-to-date data
				- TTL (time to live) can be set for data

- static website
	- used html and css for the website
- portainer (service of choice)

## Eval Sheet questions
- How does Docker work?

- How does Docker-compose work?

- Difference between using a Docker image used with docker-compose and without

- The benefit of Docker compared to VMs
	Docker and Virtual Machine
		- both virtualisation tools
		- Docker
			- virtualises the applciations layer
			- uses kernel of the host
		- vm
			- has own kernel level
	-> Docker image is much smaller than vm
	-> Docker container start and run much faster
	-> VM can be run with any OS on any OS Kernel
		-> Docker cannot because the OS might not be compatible with Machine's Kernel (linux Docker and Windows Kernel)

- The pertinence of the directory structure required for the subject

- simple explanation of docker-network
	-> Docker creates it's an isolated network in which the containers are running in
	-> when two containers are created in the same network the can communciate with just their name (no ports needed)

- explain how to log into the SQL Database as root but with no password

