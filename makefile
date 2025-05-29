# Project management for Airflow + dbt

## ------------------------
## Container management
## ------------------------

up-build:
	docker compose up -d --build

up:
	docker compose up -d

down:
	docker compose down

restart:
	docker compose down
	docker compose up -d

reset: # DANGER: Will remove everything in docker images,volumes and even networks
	docker compose down -v
	docker system prune -fa --volumes
	docker compose up -d --build

## ------------------------
## Debugging + Shell Access
## ------------------------

sh:
	docker exec -it dbt_core /bin/bash

dbsh:
	docker exec -it dbt_postgres psql -U ${DB_USER} ${DB_DATABASE}

airflow-sh:
	docker exec -it airflow bash

scheduler-sh:
	docker exec -it airflow_scheduler bash

## ------------------------
## Airflow commands
## ------------------------

airflow-init:
	docker compose run --rm airflow-init

airflow-db-reset:
	docker exec -it airflow bash -c "airflow db reset -y && airflow db init"

airflow-user:
	docker exec -it airflow bash -c "airflow users create --username admin --firstname Admin --lastname Admin --role Admin --email admin@example.com --password admin"

## ------------------------
## dbt commands (run from container)
## ------------------------

dbt-run:
	docker exec -it dbt_core bash -c "cd /usr/app/online_retail && dbt run"

dbt-test:
	docker exec -it dbt_core bash -c "cd /usr/app/online_retail && dbt test"

dbt-clean:
	docker exec -it dbt_core bash -c "cd /usr/app/online_retail && dbt clean"

dbt-docs:
	docker exec -it dbt_core bash -c "cd /usr/app/online_retail && dbt docs generate && dbt docs serve"

## ------------------------
## Volume + Cache Inspection
## ------------------------

volumes:
	docker volume ls

clean:
	docker system prune -fa --volumes

