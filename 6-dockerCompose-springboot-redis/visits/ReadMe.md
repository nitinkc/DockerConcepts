# Getting Started

To test from Local, run redis 
```shell

```

Using redis stack so that UI can be used. If only redis is used as image, a simple redis server is provided
image: redis/redis-stack:latest #redis


# Redis UI
Access Redis UI from [http://localhost:8001/redis-stack/browser](http://localhost:8001/redis-stack/browser)

# 
For `- "8080:8088"`

The app is accissible on port `8080` via docker. Within Docker, the app is running on port `8088`

[http://localhost:8080/actuator/health](http://localhost:8080/actuator/health)

[http://localhost:8080/](http://localhost:8080/)


```dockerfile
services:
  spring-boot-app:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "8080:8088"
```