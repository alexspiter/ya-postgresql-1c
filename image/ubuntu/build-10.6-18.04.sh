#!/bin/bash
 
docker build --build-arg pgtag=10.6 --build-arg pgversion=1c-10 --tag=silverbulleters/ya-docker-postgresql-1c:10.6 ./18.04
