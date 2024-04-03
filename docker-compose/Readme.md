
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



docker-compose down
```

## cleaning
```shell
docker builder prune --all


```