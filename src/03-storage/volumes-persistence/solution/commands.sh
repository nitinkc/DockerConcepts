#!/usr/bin/env bash

# (1) postgres with NO volume — data lives in the writable container layer
docker run -d --name pg-nowrite -e POSTGRES_PASSWORD=dev postgres:16-alpine
sleep 5
docker exec -it pg-nowrite psql -U postgres -c "CREATE TABLE t(i int); INSERT INTO t VALUES (42);"

# (2) destroy it -> data gone
docker rm -f pg-nowrite
docker run -d --name pg-nowrite -e POSTGRES_PASSWORD=dev postgres:16-alpine
sleep 5
docker exec -it pg-nowrite psql -U postgres -c "SELECT * FROM t;"   # ERROR: relation "t" does not exist
docker rm -f pg-nowrite

# (3) named volume — managed by docker under /var/lib/docker/volumes
docker volume create pgdata

# (4) postgres backed by the named volume
docker run -d --name pg-vol -e POSTGRES_PASSWORD=dev -v pgdata:/var/lib/postgresql/data postgres:16-alpine
sleep 5

# (5) write, kill, recreate -> data survives
docker exec -it pg-vol psql -U postgres -c "CREATE TABLE t(i int); INSERT INTO t VALUES (42);"
docker rm -f pg-vol
docker run -d --name pg-vol -e POSTGRES_PASSWORD=dev -v pgdata:/var/lib/postgresql/data postgres:16-alpine
sleep 5
docker exec -it pg-vol psql -U postgres -c "SELECT * FROM t;"   # row 42 is back
docker rm -f pg-vol

# (6) bind mount host dir into nginx
docker run -d --name site-dev -p 8080:80 -v "$PWD/site:/usr/share/nginx/html" nginx:alpine
curl localhost:8080

# (7) edit site/index.html on the host -> instant change
echo "<h1>edited on host</h1>" > site/index.html
curl localhost:8080
docker rm -f site-dev

# (8) tmpfs — RAM only
docker run --name tmpfs-demo --tmpfs /secrets alpine sh -c "echo topsecret > /secrets/token.txt && cat /secrets/token.txt"
docker start -a tmpfs-demo   # file is gone — /secrets was in memory

# cleanup
docker rm -f tmpfs-demo 2>/dev/null
docker volume rm pgdata
