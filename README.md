# DockerConcepts

MySql mysql_learning

docker pull MySql

docker run -d \
  --name=mysql_learning \
  --env="MYSQL_ROOT_PASSWORD=root" \
  --env="MYSQL_PASSWORD=root" \
  -v /Users/nitin/Downloads/docker_data:/var/lib/mysql \
  -p=3306:3306 \
  mysql

docker exec -it mysql_learning mysql -uroot -p
