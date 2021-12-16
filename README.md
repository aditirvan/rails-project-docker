# README

This README would normally document whatever steps are necessary to get the
application up and running.

Script to use:
```
docker network create rails-network
docker build -t rails-project:latest .
docker run --detach --network rails-network --name mariadb --env MARIADB_USER=irvan --env MARIADB_PASSWORD=Adhithia#123 --env MARIADB_ROOT_PASSWORD=Adhithia#123  mariadb:latest
docker run --detach --network rails-network --name rails-project -p 8080:80 rails-project:latest
```