all: build

build:
	@docker build --tag=silverbulleters/ya-docker-postgresql-1c .

release: build
	@docker build --tag=silverbulleters/ya-docker-postgresql-1c:latest .
