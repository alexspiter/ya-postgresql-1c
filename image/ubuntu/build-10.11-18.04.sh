#!/bin/bash
 
docker build --build-arg pgtag=10.11 --build-arg pgversion=1c-10 --tag=silverbulleters/ya-docker-postgresql-1c:10.11 ./18.04
