#!/bin/bash
 
docker build --build-arg pgtag=11.7 --build-arg pgversion=1c-11 --tag=silverbulleters/ya-docker-postgresql-1c:11.7 ./18.04
