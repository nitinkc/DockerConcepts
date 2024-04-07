# Getting Started

To test from Local, run redis 
```shell
docker run -d --name redis-stack -p 6379:6379 -p 8001:8001 redis/redis-stack:latest
```

Access Redis UI from [http://localhost:8001/redis-stack/browser](http://localhost:8001/redis-stack/browser)

Then run the Spring boot app which uses the config from `application.properties` and test the following URL's

[http://localhost:8080/actuator/health](http://localhost:8080/actuator/health)

[http://localhost:8080/](http://localhost:8080/)

# Via Docker-Compose

**The Redis service in docker-compose**

Using `redis stack` so that UI can be used. If only `redis` is used as image, a simple redis server is provided
image: redis/redis-stack:latest #redis

```dockerfile
  redis-server: #This is the server name that goes in config : new Jedis("redis-server", 6379);
    image: redis/redis-stack:latest #redis # redis doesn't provide the UI to visualize
    ports:
      - "6379:6379"
      - "8001:8001"
    networks:
      - my-network
```

**The Spring boot build and execute service**

The `spring-boot-app` service uses the stages in the `Dockerfile`
```dockerfile
services:
  spring-boot-app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8080:8088"
```

It exposes the port via `- "8080:8088"`

The app is accessible on port `8080` via docker. Within Docker, the app is running on port `8088`


[http://localhost:8080/actuator/health](http://localhost:8080/actuator/health)

[http://localhost:8080/](http://localhost:8080/)



