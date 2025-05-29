# https://github.com/scriptstar/dbt_pg_project/blob/master/makefile
## docker management

up-build:
	docker compose up -d --build

up:
	docker compose up -d 

# down containers
down:
	docker compose down 

# List all volumes
volumes: 
	docker volume ls  

restart:
	docker compose down 
	docker compose up -d
	
reset:
	docker compose down -v # down the working containers and volumes
	docker system prune -fa # remove all containers, images and their caches
	docker system prune -fa --volumes # Remove containers and volumes
	docker compose up -d --build  # Start fresh, this will trigger data initialization again

sh:
	docker exec -it dbt_core /bin/bash

dbsh:
	docker exec -it dbt_postgres psql -U ${DB_USER} ${DB_DATABASE}

docs:
	dbt docs generate && dbt docs serve