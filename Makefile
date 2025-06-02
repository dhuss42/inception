BUILD_DIR= cd ./src

# up all containers
up:
	$(BUILD_DIR) && docker compose up --build
# down all containers
# start all containers
# stop all containers
# restart all containers

down:
	$(BUILD_DIR) && docker compose down

# show status containers, images, networks
status:
	@echo "\n$(BLUE)============running containers============$(RESET)\n"
	@$(BUILD_DIR) && docker ps
	@echo "\n$(BLUE)============all containers============$(RESET)\n"
	@$(BUILD_DIR) && docker ps -a
	@echo "\n$(BLUE)============images============$(RESET)\n"
	@$(BUILD_DIR) && docker images
	@echo "\n$(BLUE)============networks============$(RESET)\n"
	@$(BUILD_DIR) && docker network ls

# help to list all commands
help:
	@echo "\n$(YELLOW)============list of make commands============\n"
	@echo "\tmake up:\truns docker compose up in src directory"
	@echo "\tmake down:\truns docker compose down in src directory"
	@echo "\tmake status:\tdisplays status of all running containers, containers, images and networks$(RESET)"

.PPONY: up down start stop restart status help

#----------Colours----------#
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
MAGENTA=\033[0;35m
CYAN=\033[0;36m
WHITE=\033[1;37m
RESET=\033[0m