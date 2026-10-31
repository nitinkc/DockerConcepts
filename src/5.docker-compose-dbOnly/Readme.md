# Check versions
```shell
docker --version

docker-compose --version
```


```shell
cd db
chmod 777 01-init.sh
chmod 777 02-schema.sql
chmod 777 03-data.sql
cd ../
docker-compose up --build
docker-compose build --no-cache

# to rerun, first shot down and do compose again
docker-compose down
```

## cleaning

```shell
docker builder prune --all
```

# Check the running container
```shell
docker exec -it 5242c195c2c9b9ae2b98d7fa901514289c71b4d7a999d897e416674da668179c  /bin/bash   
cd docker-entrypoint-initdb.d
ls -lrt
```
# Metabase
```shell
docker.for.mac.localhost
```
![metabase_config.png](..%2Fresources%2Fmetabase_config.png)

# All the files from the db folder will run in naming sequence

01-init.sh - creates a new user, creates a db and creates a table

