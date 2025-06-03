
COMPOSE= ./src/compose.yaml
ENV_FILE= ./src/.env
NAME= inception

# compose
# -p project name
# -f compose file location
# - --env-file env file location
# up
# -d detached mode to regain terminal (not active at the moment because no debug messages when detached)
# --build builds images before starting containers
up:
	@echo "$(MAGENTA)============Building images... Creating and starting containers... for $(NAME)============$(RESET)"
	docker compose -p $(NAME) -f $(COMPOSE) --env-file $(ENV_FILE) up --build

down:
	@echo "$(MAGENTA)============Stopping containers... removing containers and networks... for $(NAME)============$(RESET)"
	@docker compose -p $(NAME) -f $(COMPOSE) down

stop:
	@echo "$(MAGENTA)============Stopping services for $(NAME)============$(RESET)"
	@docker compose -p $(NAME) -f $(COMPOSE) stop

start:
	@echo "$(MAGENTA)============Starting services for $(NAME)============$(RESET)"
	@docker compose -p $(NAME) -f $(COMPOSE) start

restart:
	@echo "$(MAGENTA)============Restarting services for $(NAME)============$(RESET)"
	@docker compose -p $(NAME) -f $(COMPOSE) restart

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

clean:
	@echo "$(YELLOW)Removing containers that are not running...$(RESET)"
	@docker container prune
	@echo "$(YELLOW)Removing images that are not running...$(RESET)"
	@docker image prune -a
	@echo "$(YELLOW)Removing networks...$(RESET)"
	@docker network prune

fclean: stop
	@echo "$(YELLOW)Removing unused data across the Docker system$(RESET)"
	@docker system prune -a --volumes
	@if docker volume ls | grep -q '^mariadb$$'; then \
		echo "$(YELLOW)Removing local mariadb volume$(RESET)"; \
		docker volume rm mariadb; \
	else \
		echo "$(YELLOW)mariadb volume does not exist$(RESET)"; \
	fi

re: fclean up

# help to list all commands
help:
	@echo "\n$(YELLOW)============list of make commands============\n"
	@echo "\tmake up:\truns docker compose up in src directory"
	@echo "\tmake down:\truns docker compose down in src directory"
	@echo "\tmake clean:\tremoves stopped containers, unused images, unused networks"
	@echo "\tmake fclean:\tremoves all data"
	@echo "\tmake status:\tdisplays status of all running containers, containers, images and networks$(RESET)"

.PPONY: up down start stop restart status clean fclean re help

#----------Colours----------#
RED=\033[0;31m
GREEN=\033[0;32m
YELLOW=\033[0;33m
BLUE=\033[0;34m
MAGENTA=\033[0;35m
CYAN=\033[0;36m
WHITE=\033[1;37m
RESET=\033[0m