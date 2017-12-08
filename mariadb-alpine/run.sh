#!/usr/bin/env bash
docker rm -f mariadb
docker run -d -v /data/mysql:/data -p 3306:3306 --name mariadb timhaak/mariadb-alpine
