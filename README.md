# DockerConcepts

## Important Docker Commands


### For Docker hub images

1. Create Repository on https://hub.docker.com/ . <repo-name>

2. Log into the Docker Hub from the command line

`docker login --username=nitinkc --email=gs.nitin@gmail.com`

2. Check the image ID (on local machine)using `docker images`

3. Tag the image `docker tag bb38976d03cf dockerhub-user-name/<repo-name>e:tag-name`

4. Push the image to the repository  created `docker push nitinkc/<repo-name>`

##### Example

```sh
docker login --username=nitinkc
docker tag 33a7bad180b7 nitinkc/messenger-app:my-angular-app
docker push nitinkc/messenger-app
docker pull nitinkc/messenger-app:my-angular-app
docker run --publish 5000:5000 -t nitinkc/messenger-app:my-angular-app

```

## Important Docker Commands

```sh
# To list all running Docker containers
docker ps --all

List all containers, both running and stopped
docker system prune


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
