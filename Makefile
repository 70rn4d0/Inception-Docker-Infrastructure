NAME = inception
COMPOSE_FILE = srcs/docker-compose.yml
DATA_PATH = /home/aech-chi/data

GREEN = \033[0;32m
YELLOW = \033[0;33m
RED = \033[0;31m
NC = \033[0m

all: up

$(DATA_PATH)/mariadb $(DATA_PATH)/wordpress:
	@echo "$(YELLOW)Creating data directories at $(DATA_PATH)...$(NC)"
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress

up: $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress
	@echo "$(GREEN)Building and starting Inception...$(NC)"
	@docker compose -f $(COMPOSE_FILE) up -d --build

down:
	@echo "$(YELLOW)Stopping Inception...$(NC)"
	@docker compose -f $(COMPOSE_FILE) down

clean: down
	@echo "$(RED)Cleaning up containers and images...$(NC)"
	@docker system prune -af


fclean: clean
	@echo "$(RED)Removing data directories...$(NC)"
	@docker compose -f $(COMPOSE_FILE) down -v 
	@sudo rm -rf $(DATA_PATH)/mariadb $(DATA_PATH)/wordpress

re: fclean all

logs:
	@docker compose -f $(COMPOSE_FILE) logs -f

ps:
	@docker compose -f $(COMPOSE_FILE) ps

.PHONY: all up down clean fclean re logs ps
