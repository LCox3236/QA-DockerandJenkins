#!/bin/bash

docker rm -f $(docker ps -aq)
docker rmi -f $(docker images)
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images)
docker network rm $(docker network ls -q) 
docker network rm $(docker network ls -q)
docker volume rm $(docker volume ls -q)
docker volume rm $(docker volume ls -q)

#Network
docker network create my-network

#Volume
docker volume create mysql-volume

# Save current directory
original_dir=$(pwd)

#Build images(mysql, flask-app)
cd db
pwd
docker build -t mysql .
cd "$original_dir"

cd flask-app
pwd
docker build -t flask-app .
cd "$original_dir"

cd nginx
pwd
docker build -t nginx .
cd "$original_dir"

#Run Containers
docker run --name mysql-db -v mysql-data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=password -d mysql

docker run -d -p 5000:80 --name flask-app flask-app

docker run -d -p 80:80 --name nginx --mount type=bind,source=/home/ubuntu/dockerfileexercise/Task2/nginx/nginx.conf,target=/etc/nginx/nginx.conf nginx

docker ps -a