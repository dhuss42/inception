# Gather information on unknown concepts
## mandatory part
		- Docker
		- Dockerfiles
			-> blueprint for build images
			-> Syntax:
				- First line: FROM <image>:<version>
					-> install image
				- environment variables can also be defined in docker file (alternative to docker compose)
					- ENV <environment variables>
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
			- best practice for writing docker-files
			- lastest tag(prohibited)
			- Docker secrets
		- Docker Images
			-> the actual package
			-> the artifact that can be moved around
			-> not running
			-> image has a version
		- Container
			-> actual start the application
			-> environment that is running for am image
			-> running as oppossed to the Docker Image which is not running
			-> has a port, makes it possible to take to an application that is running inside a container
			-> has a virtual file system
			-> own abstraction of an OS
		- automatic restart of containers if they crash
		- daemons
		- volume
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
						environment:
							<variables>
					<container 2>:
						...

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
		- TLSv1.2 or TSLv1.3

		- Wordpress
		- php-fpm

		- MariaDB

		- API
		- API keys

## bonus part
		- redis cache for Wordpress
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

## debug commands
	- docker logs <contaienr id>
		display the logs
	- docker logs <name of container>
		display the logs
	- docker exec -it <container id> /bin/bash
		go inside the container as a root user, able to execute commands inside the container
		it stand for interactive terminal
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