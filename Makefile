# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: dhuss <dhuss@student.42.fr>                +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/06/20 11:51:47 by dhuss             #+#    #+#              #
#    Updated: 2025/06/23 16:33:52 by dhuss            ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE= ./srcs/docker-compose.yml
ENV_FILE= ./srcs/.env
NAME= inception

up: setup
	@echo "$(MAGENTA)============Building images... Creating and starting containers... for $(NAME)============$(RESET)"
	@docker compose -p $(NAME) -f $(COMPOSE) --env-file $(ENV_FILE) up -d --build

down:
	@echo "$(MAGENTA)============Stopping containers... removing containers and networks... for $(NAME)============$(RESET)"
	@docker compose -p $(NAME) -f $(COMPOSE) down

stop:
	@echo "$(MAGENTA)============Stopping services for $(NAME)============$(RESET)"
	@docker compose -p $(NAME) -f $(COMPOSE) stop

start:
	@echo "$(MAGENTA)============Starting services for $(NAME)============$(RESET)"
	@docker compose -p $(NAME) -f $(COMPOSE) start

status:
	@echo "\n$(BLUE)============running containers============$(RESET)\n"
	@docker ps
	@echo "\n$(BLUE)============all containers============$(RESET)\n"
	@docker ps -a
	@echo "\n$(BLUE)============images============$(RESET)\n"
	@docker images
	@echo "\n$(BLUE)============networks============$(RESET)\n"
	@docker network ls
	@echo "\n$(BLUE)============volumes============$(RESET)\n"
	@docker volume ls
	@echo "\n$(BLUE)============disk usage============$(RESET)\n"
	@docker system df

clean: stop
	@echo "$(YELLOW)Removing containers that are not running...$(RESET)"
	@docker container prune
	@echo "$(YELLOW)Removing images that are not running...$(RESET)"
	@docker image prune -a
	@echo "$(YELLOW)Removing networks...$(RESET)"
	@docker network prune
	@sudo rm -rf /home/dhuss/data/mariadb
	@sudo rm -rf /home/dhuss/data/wp_nginx
	@sudo rm -rf /home/dhuss/data/portainer

fclean: stop clean
	@echo "$(YELLOW)Removing unused data across the Docker system$(RESET)"
	@docker system prune -a --volumes
	@if [ $$(docker volume ls -q | grep "mariadb") ]; then \
		echo "$(YELLOW)Removing mariadb volume$(RESET)"; \
		docker volume rm $$(docker volume ls -q | grep "mariadb"); \
	else \
		echo "$(YELLOW)No mariadb volume to remove$(RESET)"; \
	fi
	@if [ $$(docker volume ls -q | grep "wp_nginx") ]; then \
		echo "$(YELLOW)Removing wp_nginx volume$(RESET)"; \
		docker volume rm $$(docker volume ls -q | grep "wp_nginx"); \
	else \
		echo "$(YELLOW)No wp_nginx volume to remove$(RESET)"; \
	fi
	@if [ $$(docker volume ls -q | grep "portainer_data") ]; then \
		echo "$(YELLOW)Removing portainer volume$(RESET)"; \
		docker volume rm $$(docker volume ls -q | grep "portainer_data"); \
	else \
		echo "$(YELLOW)No portainer volume to remove$(RESET)"; \
	fi
	@echo "$(YELLOW)Removing host bind-mount directories with sudo...$(RESET)"
	@sudo rm -rf /home/dhuss/data/mariadb
	@sudo rm -rf /home/dhuss/data/wp_nginx
	@sudo rm -rf /home/dhuss/data/portainer

re: fclean up

setup:
	@echo "$(CYAN)Creating bind mount directories...$(RESET)"

	@if [ ! -d /home/dhuss/data/mariadb ]; then \
		echo "$(YELLOW)Creating /home/dhuss/data/mariadb$(RESET)"; \
		mkdir -p /home/dhuss/data/mariadb; \
		sudo chown -R 999:999 /home/dhuss/data/mariadb; \
	else \
		echo "$(GREEN)/home/dhuss/data/mariadb already exists$(RESET)"; \
	fi

	@if [ ! -d /home/dhuss/data/wp_nginx ]; then \
		echo "$(YELLOW)Creating /home/dhuss/data/wp_nginx$(RESET)"; \
		mkdir -p /home/dhuss/data/wp_nginx; \
		sudo chown -R 33:33 /home/dhuss/data/wp_nginx; \
	else \
		echo "$(GREEN)/home/dhuss/data/wp_nginx already exists$(RESET)"; \
	fi

	@if [ ! -d /home/dhuss/data/portainer ]; then \
		echo "$(YELLOW)Creating /home/dhuss/data/portainer$(RESET)"; \
		mkdir -p /home/dhuss/data/portainer; \
		sudo chown -R 1000:1000 /home/dhuss/data/portainer; \
	else \
		echo "$(GREEN)/home/dhuss/data/portainer already exists$(RESET)"; \
	fi

.PHONY: up down start stop status clean fclean re setup

#----------Colours----------#
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
MAGENTA=\033[0;35m
CYAN=\033[0;36m
WHITE=\033[1;37m
RESET=\033[0m