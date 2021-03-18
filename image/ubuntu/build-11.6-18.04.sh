#!/bin/bash
 
docker build --build-arg pgtag=11.6 --build-arg pgversion=1c-11 --tag=silverbulleters/ya-docker-postgresql-1c:11.6 ./18.04
