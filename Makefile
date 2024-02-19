.PHONY: *

pretty:
	bunx prettier --write .
	shfmt -w .

install:
	sudo ./setup-nginx-docker.sh

run:
	docker compose up

build:
	docker compose build

exec:
	docker exec -it nginx_server bash


dev: build run

css:
	bunx tailwindcss -i ./html/css/input.css -o ./html/css/output.css --watch