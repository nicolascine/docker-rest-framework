SHELL := /bin/bash

all: build migrate run

run: build
	docker-compose up

build: .built

.built:
	docker-compose build
	touch .built

stop:
	docker-compose stop

restart: build
	docker-compose restart web

clean: stop
	docker-compose rm -f
	rm -f .built

logs:
	docker-compose logs

migrate: build
	docker-compose run web /usr/local/bin/python manage.py migrate

statics: build
	docker-compose run web /usr/local/bin/python manage.py collectstatic --clear

.PHONY: all run build stop restart clean logs migrate statics