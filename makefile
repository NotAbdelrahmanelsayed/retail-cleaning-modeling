# https://github.com/scriptstar/dbt_pg_project/blob/master/makefile
## docker management

up-build:
	docker compose up -d --build

up:
	docker-compose up -d 

# down containers
down:
	docker compose down 

# List all volumes
volumes: 
	docker volume ls  

restart:
	docker compose down -v  # Remove containers and volumes
	docker compose up -d --build  # Start fresh, this will trigger data initialization again

sh:
	docker exec -it dbt_core /bin/bash


dbsh:
	docker exec -it dbt_postgres psql -U ${DB_USER} ${DB_DATABASE}