.PHONY: *

pretty:
	cd html && npx prettier --write .

install:
	sudo ./setup-nginx-docker.sh

run:
	docker compose up

build:
	docker compose build

exec:
	docker exec -it nginx_server bash

dev: build run
