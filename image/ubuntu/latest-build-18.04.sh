#!/bin/bash
 
docker build --build-arg pgtag=12.2 --build-arg pgversion=1c-12 --tag=silverbulleters/ya-docker-postgresql-1c:12.2 ./18.04
