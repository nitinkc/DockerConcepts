# DockerConcepts

## Important Docker Commands

```sh
docker ps --all
docker system prune

 docker run --publish 5000:5000 -t nitinkc/messenger:0.0.1-SNAPSHOT\n

# Show all containers
 sudo docker ps -a
 sudo docker ps -aq

 # Remove Containers
 docker container rm 6d0806087e50
 docker container rm 8cf7ae980534

 docker system prune
 docker ps -l
```


## MySql mysql_learning

```sh
docker pull MySql

docker run -d \
  --name=mysql_learning \
  --env="MYSQL_ROOT_PASSWORD=root" \
  --env="MYSQL_PASSWORD=root" \
  -v /Users/nitin/Downloads/docker_data:/var/lib/mysql \
  -p=3306:3306 \
  mysql

docker exec -it mysql_learning mysql -uroot -p
```
