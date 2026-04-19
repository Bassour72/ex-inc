
all:
	@mkdir -p /home/${USER}/data/mariadb
	@mkdir -p /home/${USER}/data/wordpress

	@docker compose -f ./srcs/docker-compose.yml up -d --build

up: all

down:
	
	@docker compose -f ./srcs/docker-compose.yml down


clean:
	@docker compose -f srcs/docker-compose.yml down --rmi all -v

fclean: clean
#	@sudo docker system prune -a --volumes
	@docker rmi $$(docker images -q --filter "reference=mariadb" --filter "reference=wordpress" --filter "reference=nginx" --filter "reference=redis" --filter "reference=static_site" --filter "reference=cadvisor" --filter "reference=adminer" --filter "reference=ftp") 2>/dev/null || true
	@docker system prune -f --volumes


	@sudo rm -rf /home/${USER}/data/mariadb
	@sudo rm -rf /home/${USER}/data/wordpress
	
	@sudo rm -rf /home/${USER}/data/redis
	@sudo rm -rf /home/${USER}/data/advisor


re: fclean all

.PHONY: all down clean fclean re
