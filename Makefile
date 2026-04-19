DATA_PATH = /home/ybassour/data
all:
	@mkdir -p $(DATA_PATH)/mariadb
	@mkdir -p $(DATA_PATH)/wordpress
	@docker compose -f ./srcs/docker-compose.yml up -d --build

up: all

down:
	
	@docker compose -f ./srcs/docker-compose.yml down


clean:
	@docker compose -f srcs/docker-compose.yml down --rmi all -v

fclean:
	@echo "Stopping containers and removing volumes..."
	@docker compose -f srcs/docker-compose.yml down --rmi all -v
	@echo "Cleaning system and orphan volumes..."
	@docker system prune -af --volumes
	@echo "Deleting persistent data directories..."
	@sudo rm -rf $(DATA_PATH)
	@echo "Full cleanup complete."


re: fclean all

.PHONY: all down clean fclean re
