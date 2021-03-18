#!/bin/bash
 
docker build --build-arg pgtag=11.5 --build-arg pgversion=1c-11 --tag=silverbulleters/ya-docker-postgresql-1c:11.5 ./18.04
