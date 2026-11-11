# Spring Boot + Redis via Compose

**Lesson:** [05 — Docker Compose](https://github.com/nitinkc/DockerConcepts/blob/main/docs/05-docker-compose.md)

## Local (no compose)

Run Redis on the host, then the app reads `application.properties`
(`redis.server.hostname=localhost`):

```shell
docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
./gradlew bootRun
```

Redis UI: [http://localhost:8001/redis-stack/browser](http://localhost:8001/redis-stack/browser)
App: [http://localhost:8080/actuator/health](http://localhost:8080/actuator/health) · [http://localhost:8080/](http://localhost:8080/)

## Via Docker Compose

`SPRING_PROFILES_ACTIVE=docker` switches config to
`application-docker.properties`, where `redis.server.hostname=redis-server` —
the **service name**, resolved by Compose's embedded DNS on `my-network`.

```yaml
services:
  spring-boot-app:
    build:
      context: .
      dockerfile: Dockerfile       # multi-stage: gradle build -> jar-only runtime
    ports:
      - "8080:8088"                # host 8080 -> container 8088 (server.port)
    environment:
      SPRING_PROFILES_ACTIVE: "docker"
    depends_on:
      - redis-server
    networks:
      - my-network

  redis-server:                    # service name == DNS hostname inside the net
    image: redis/redis-stack:latest
    ports:
      - "6379:6379"
      - "8001:8001"
    networks:
      - my-network
```

```shell
cd src/05-compose/springboot-redis/visits
docker compose up --build
# test: http://localhost:8080/  http://localhost:8080/actuator/health
docker compose down
```

> `redis` = server only; `redis/redis-stack` adds the Redis Insight UI on :8001.

## Practice from memory

1. Write the compose file from scratch — services, ports, `depends_on`,
   `environment`, `networks`.
2. Change the Redis service name to `cache`, update
   `application-docker.properties`, bring it up — prove DNS follows the name.
3. `docker compose up`, then in another terminal
   `docker compose exec spring-boot-app sh` and `wget -qO- http://redis-server:6379`
   — connection refused is *correct* (Redis speaks RESP, not HTTP), but DNS
   resolved. Try `redis-cli ping` instead.
