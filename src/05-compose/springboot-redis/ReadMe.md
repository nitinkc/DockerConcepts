# Lab: Compose — Spring Boot + Redis (service discovery)

**Lesson:** [05 — Docker Compose](https://github.com/nitinkc/DockerConcepts/blob/main/docs/05-docker-compose.md) · [04 — Networking](https://github.com/nitinkc/DockerConcepts/blob/main/docs/04-networking.md)

The capstone lab: a Spring Boot app and Redis on a Compose-created bridge
network, talking to each other **by service name** (`redis-server`) via
Docker's embedded DNS — no IPs anywhere.

Also demonstrates a real **multi-stage Dockerfile** (`visits/Dockerfile`):
Gradle builds the jar in stage 1, the runtime image carries only the jar.

The app lives in [`visits/`](https://github.com/nitinkc/DockerConcepts/tree/main/src/05-compose/springboot-redis/visits) — see its README for run steps.

## Endpoints

- [http://localhost:8080/](http://localhost:8080/) — visit counter (increments in Redis)
- [http://localhost:8080/actuator/health](http://localhost:8080/actuator/health)
- [http://localhost:8080/actuator/health/redis-health](http://localhost:8080/actuator/health/redis-health)
- [http://localhost:8001/redis-stack/browser](http://localhost:8001/redis-stack/browser) — Redis Insight UI
