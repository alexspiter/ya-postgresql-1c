#!/bin/bash
 
docker build --build-arg pgtag=12.1 --build-arg pgversion=1c-12 --tag=silverbulleters/ya-docker-postgresql-1c:12.1 ./18.04
