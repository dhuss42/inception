# Gather information on unknown concepts
## mandatory part
		- Docker
		- Dockerfiles
			-> blueprint for building images
			-> Syntax:
				- First line: FROM <image>:<version>
					-> install image
				- ENV <environment variables>
					- environment variables can also be defined in docker file (alternative to docker compose)
					- better to do in docker dompose
					- .env file (?)
				- RUN - execute any Linux command
					- will apply to the container environment not the host
				- COPY <src> <target>
					- executes on the host
				- CMD 
					- (?)
					- entrypoint command
			- PID 1
				-> first process started during system boot
				-> all other process are then started by PID 1 (parent of every process in the system)
				-> in docker the process that runs PID 1 is crucial because it is responsible for managing all other process inside the container
				-> PID 1 handles and reviews signals from the Docker host
				-> Shell Form vs Exec Form (recommended)
					-> Shell Form
						CMD python app.py == equivalent to ==> /bin/sh -c "python app.py"
							-> a shell becomes PID 
							-> python is a child process
							-> signals like SIGTERM (used to stop a container) are sent to the shell and not always forwarded properly to the child process
					-> Exec Form
						CMD ["python", "app.py"]
							-> runs python as PID 1
							-> receives signals directly
							-> gracefully shuts down if it can handle these signals
			- best practice for writing docker-files (see further down)
			- lastest tag(prohibited)
				-> telling Docker to use the image tagged latest from the Docker registry
				-> does not mean the ost up-to-date version
				-> why not to use
					-> non-deterministc: latest today is not latest tomorrow necessarliy
					-> could break if changes in the latest affect things it did not in the prior latest version
					-> had to debug because you don't know which version you are using
			- Docker secrets
				-> secure way to manage sensitive information
				-> they keep this info out of Dockerfiles, images, envs...
		- Docker Images
			-> the actual package
			-> the artifact that can be moved around
			-> not running
			-> image has a version
		- Container
			-> actual start the application
			-> environment that is running from an image
			-> running as oppossed to the Docker Image which is not running
			-> has a port, makes it possible to talk to an application that is running inside a container
			-> has a virtual file system
			-> own abstraction of an OS
		- automatic restart of containers if they crash
		- daemons
			- At the core of Docker's operation is the Docker daemon, an underlying background service running on the host OS, responsible for executing all Docker tasks.
			- service responsible for orchestrating container lifecycle management. 
			- container creation, execution, and monitoring. In a nutshell, it acts as a bridge between the Docker client and the Docker engine following Client-Server Architecture. Docker daemon executes commands issued by the client by translating them into actionable operations within the Docker environment.
			https://www.geeksforgeeks.org/what-is-docker-daemon/ 
		- volume
			-> used for data persistance
				-> for example Databases
			-> Folder in physical host file system (host) is mounted into the virtual file system of Docker
			-> when data is written in the container file system it is automatically repliacted on the host file system and vice versa
			-> different Volume Types
				-> docker run -v </path/to/host/directory>:<path/to/container/directory>
					-> Host Volume
					-> decide where on the host file system the reference is made /mount into the container
				-> docker run -v <path/to/container>
					-> Anonymous Volume
					-> for each container a folder is generated that gets mounted to that container
				-> docker run -v name:</path/to/container>
					-> Named Volumes
					-> you can reference the volume by name
					-> preferred Volume type

		- Docker Compose
			-> makes running multiple containers with commands much easier
			-> structured way to contain docker commands
			-> takes care of creating a common network
			-> indentation has to be correct
			-> version of the docker compose
			-> services:
					<container 1>:
						image: <image name>
						ports:
							<host>:<container>
						volumes:
							<named Volume>:/path/container
						environment:
							<variables>
					<container 2>:
						...
			-> list all the volumes that you defined
			-> volumes:
				<name>:
					driver: local // not sure here
			-> possible to have multiple containers mounted to the same volume

		- docker-network
			-> Docker creates it's an isolated network in which the containers are running in
			-> when two containers are created in the same network the can communciate with just their name (no ports needed)
			-> applications that run outside of docker can connect to the network via localhost<port number>
			- docker network create <name to give>
				create docker network with given name
			- docker network ls
				list docker networks

		- ports
			docker ps lists ports, where the container is listening for incoming requests
			Container Port vs Host Port
				-> multiple container can run on host Machine
				-> your laptop has only certain ports available
				-> need to create a binding between host port and container port
					-> conflicts if you open the same port twice on the host
					-> two separate containers can listen from the same port number
					-> specify the binding during the run command

		- NGINX
			- basic use case
				-> browser requested a webpage from one webserver and the webserver responded to this request
					-> webserver refers both the physical machine and the software running on that machine
					-> Primary function is to serve a web page
			- proxy Server
				- load balancer
					-> proxies (do something on someoneelse's behalf) the request to the webservers
					-> sits at the entry and distrubtes the load to the webservers
						-> least busy
						-> distrubute equally in a cyclical manner
				- Caching
					-> assable data and store it temporarly on the proxy, send it out to requesters
				- Security
					-> one entrypoint (the proxy) reduces the attack surface a lot
					-> encrypted Communication
					-> proxy receives an encrypted message and will pass it on to the webserver which 		decyrpts it
				- Compression
					-> reduce bandwidth usage and improve load times
					-> send responses in chunks

		- TLSv1.2 or TSLv1.3 (for encryption)
			-> 1.3 optimasation of 1.2
			-> does three things
				-> Authentication
				-> Data Encryption
				-> Data Integrity
					-> has not forged or tempered with
					-> MAC algorithm
			-> https -> entrcypted form of http
				-> uses TLS (Transport Layer Securtiy)
			-> TLS two sessions (converstion between two parties)
				-> 1. TLS Handshake
					- main reason is for authentication
						-> public key asymetric 
						-> server present spublic key to client, client checks certificate, generates string encrypts it with private key and server decrypts it. Generate a master key with this string + other data. -> generate session key
					- the client has trust the identity of the server
						-> server provides a TLS Certificate for this
							-> then they uses public key protocol for authentication
							-> datafile that contains information about how owns the certificate and the authorit that issued the key + other data
							-> Certificate Authority hands out TLS Certificates (signs them with their own private key, allowing client devices to verify it)
					- establish a shared secrete key will be used for encryption
				-> 2. Encryption
					- the key is used to encrypt all ongoing messages
					- after passing the data it will be verified if the data has been altered in any way
					- if not the data will be decrypted using the same semetric secret key (semetric because used for decryption and encryption)
			-> fast for huge amounts of data
			-> impossible to break

		- Wordpress
			- free content management system
			- create websites and blogs
			- based on php
		- php-fpm
			- PHP-FPM (FastCGI Process Manager) is an alternative PHP FastCGI implementation with some additional features useful for sites of any size, especially busier sites.
			-php a server-side scripting language designed for web development, but which can also be used as a general-purpose programming language.
		- MariaDB (database Management System)
			-> Database
				-> collection of related files
			-> Database Management System
				-> software that controls the database
			-> Terminology
				- record and row are interchangable
				- column and attributes also
			-> Almost all database managemet Systems use SQL (structured query language)
			-> log into MariaDB server from command line
				mariadb -u user_name -p -h ip_address db_name

		- API
			- An interface that makes it possible for independent Apps to communicate and share data
		- API keys
			- authenticates a user when they try to access an API

## bonus part
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
			apt-get install -y redis
			redis - server 
				to start Port: 6379
			redis-cli
				- acces redis and run commands
			SET name kyle
				set key=value pair
			DELETE name
			GET <key>
			EXISTS <key>
			ttl <key>
				- shows time to live
			expire <key> <time in s>

		- FTP server
		- Adminer
		- simple static website in language of choice except php
		- service of choice

# Docker tutorial for beginners
## What is a Container
	- A way to package applications with all the necessary dependencies and configurations
	- Portable artifact, that can be esaily shared and moved
	- live in a contaienr repository
	- Public repository for Docker Containers
		- Dockerhub
	- own isolated environment
		-> packaged with all needed configuration
	- saves you from doing all the config yourself which depending on the complexity can be very error prone

	- Layer of images
		-> mostly Linux Base Image because small in size
		-> Application image on top

## Docker vs Virtual Machine
### Docker
	OS has two levels
		1. OS Kernel
			communciates with hhrdware
				cpu, memory
		2. Applciations
			run on the kernel layer

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

# commands
	- docker ps
		shows the running containers
	- docker ps -a
		lists running and stopped containers
	- docker images
		displays the images
	- docker run <name of image>
		creates the container
		can specify values
	- ctrl + c
		stops container
	- docker run -d <name of image>
		start in detached mode, returns you to the terminal prompt
	- docker run -p <port nbr host>:<port nbr container> <name of image>
		start container with ports binding of ports
	- docker run --name <name to give> <image>:<version>
		name container
	- docker stop <id of container>
		stops the container
	- docker start <id of container>
		starts the stopped contaier
	- docker pull <image name>
		pulls image from the repo to local
	- docker run <name>:<version>
		pull image and start container (docker pull and docker start in ones)
	docker rm <container id>
		deltes container
	docker rmi <image id>
		deletes image
		need to delete container first

## debug commands
	- docker logs <contaienr id>
		display the logs
	- docker logs <name of container>
		display the logs
	- docker exec -it <container id> /bin/bash
		go inside the container as a root user, able to execute commands inside the container
		it stand for interactive terminal
		bash means the shell is bash
	- docker exec -it <container name> /bin/bash
		- same as with id
	- exit to exit container

## network commands
	- docker network create <name to give>
		create docker network with given name
	- docker network ls
		list docker networks
	- docker run -p <default port host>:<default port container> -d -e <specifications> --name <name to give> --net <network name> <image>
		environmental variables can be found in Dockerhub image documentation
			-e (flag for env)

## docker compose
	- docker-compose -f <dock-compose file name> up
		will start all the containers inside the docker-compose file
	- docker-compose -f <dock-compose file name> down
		will stop all the containers inside the docker-compose file
		also removes the network and the network will be recreated

## dockerfile
	- docker build . -t <name>:<version> .
		builds an image in the provided directory from that dockerfile

# best practice for dockerfiles
https://docs.docker.com/build/building/best-practices/ 

### multi-stage build
		-> reduces size of image by separating the building of the image and the final output
### reusable stage
		-> when things are in common reduce duplication
### pick correct image
		-> small base image
		-> different images for building / testing and production, as some tools may not be needed later on
	-> Rebuild images often / don't build from
### cache
	-> Docker cache are previously built image layers stored on disk
		-> speeds up rebuildbe reusing unchanged steps
	-> --no-cache Forces Docker to rebuild everything from scratch
		-> pulls the latest available dependencies

### .dockerignore
	-> like .gitignore

### Ephemeral Container

	- Doesn’t write to local disk
	- Config is injected (e.g., env vars)
	- Can be rebuilt & replaced easily
	The app should not store session info, logs, or data inside the container.
	Instead, use:
    	- Databases for data
		- Volumes for shared persistent storage
		- Environment variables for config
		- Logging drivers or log aggregation 
		- services for logs

### don't install unncessary packages
	-> reduces:
		complexity
		dependencies
		filessize
		build times

### Decouple applications
	- one container for one service / process

### Sort multi-line arguments
	- when possible alphanumerically
	- space before \

### understand how build cache works
	-> when building an image docker steps through instructions line by line always checking if it can reuses instructions from the cache
	-> if a layer changes all subsequent layers are changed
		-> helpful to keep in mind when organising the layers inside the dockerfile
		https://docs.docker.com/build/cache/

### Dockerfile instructions
	https://docs.docker.com/reference/dockerfile/

### RUN
	- Always combine RUN apt-get update with apt-get install in the same RUN statement
		- RUN apt-get update && apt-get install -y --no-install-recommends

		rm -rf /var/lib/apt/lists/*
			deletes cache from APT install



### Virtual Machine installation
	1. download debian linux from debian.org
	2. start up virtual box
		-> tools -> new
		-> name it
		-> select debian and matching version
		-> Iso image
		-> skip unintended installation
	3. 2gb memory // stay in the green // enable core
		-> give at least 32gb for decent installation
		-> no pre-allocation
	4. settings -> advanced
		-> drag and drop feature
		-> sharing clipboards
	5. start

install Debian
	6. graphical install
	7. hostname
	8. domainname
	9. password for root
	10. user_nmae + password
	11. partition disks -> use entire disk -> all files in one partition
	12 write changes to disk -> yes
	13. select country -> closest image for debian -> continue without proxy
	13 -> survey -> no
	14 -> select a desktop environment (GNOME) -> standard system utilities
	15 -> install bootloader

	inside Debian
	ctrl F for fullscreen

	credentials
		-> on test vm
		-> root: david
		-> dhuss: 42


Transfer files between host and VM
	- ssh on vm
		sudo apt update
		sudo apt install openssh-server
		sudo systemctl enable ssh
		sudo systemctl start ssh
		sudo systemctl status ssh

	- enable bridge networking
		- vm -> settings -> network
			-> adapter 1 -> Bridge Adapter -> en0: Wi-Fi
		- ssh username@ip
		- scp -r /path/to/inception username@ip:/home/username
			-> secure copy 

install docker on vm
		https://docs.docker.com/engine/install/debian/

Run Docker on vm
	- apt update
	- apt install make

change domain to dhuss.42.fr
	- etc/hosts
		-> change to dhuss.42.fr