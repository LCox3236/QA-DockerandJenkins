docker rm -f $(docker ps -aq)
docker rmi -f $(docker images)
docker rm -f $(docker ps -aq)
docker rmi -f $(docker images)