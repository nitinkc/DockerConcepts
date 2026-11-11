---
quiz:
  enabled: true
---

# 5. Multi-Container Orchestration — Docker Compose

Compose turns a multi-container environment into a declarative YAML file:
services, networks, and volumes described once, brought up with one command.

```yaml
services:
  web:
    build: .
    ports:
      - "80:8080"
    environment:
      - DB_HOST=db
    depends_on:
      - db
    networks:
      - backend-net

  db:
    image: postgres:16-alpine
    environment:
      POSTGRES_PASSWORD: secretpassword
    volumes:
      - db_data:/var/lib/postgresql/data
    networks:
      - backend-net

volumes:
  db_data:

networks:
  backend-net:
    driver: bridge
```

!!! note
    `version:` at the top is deprecated — modern Compose ignores it.

## Networking you get for free

- Compose creates a user-defined bridge named `<project>_default` and attaches
  every service
- **Services resolve each other by service name** — `web` connects to
  `postgres://db:5432` because embedded DNS maps `db` to the container IP
- Define extra `networks:` to partition services (e.g., `frontend` vs `backend`)

## Key service fields

| Field | Purpose |
|---|---|
| `build.context` / `build.dockerfile` | build an image from a Dockerfile |
| `image` | pull (or tag the built result) |
| `ports` | `host:container` publish — the `-p` equivalent |
| `environment` / `env_file` | runtime env vars |
| `volumes` | named volumes, bind mounts (see [lesson 3](03-storage-persistence.md)) |
| `depends_on` | start order (add `condition: service_healthy` to wait on healthchecks) |
| `healthcheck` | `test`/`interval`/`retries` — gates `depends_on` conditions |
| `restart` | `no` / `always` / `on-failure` / `unless-stopped` |

## Everyday commands

```bash
docker compose up --build      # build images + start everything
docker compose up -d           # detached
docker compose ps              # service status
docker compose logs -f web     # stream one service's logs
docker compose exec db psql -U dbuser mydb   # shell into a running service
docker compose down            # stop + remove containers (keeps volumes)
docker compose down -v         # ...and remove volumes too
```

## Scaling the same service

```bash
docker compose up -d --scale web=3
```

---

## Labs — do them in order

=== "`frontend-compose`"

    `src/05-compose/frontend-compose/` — [lab page](labs/frontend-compose.md)

    React dev server; **bind-mount** hot-reload, `Dockerfile.dev`, the
    `/app/node_modules` volume trick.

=== "`compose-db`"

    `src/05-compose/compose-db/` — [lab page](labs/compose-db.md)

    Postgres with `env_file`, a `healthcheck`, and
    `/docker-entrypoint-initdb.d/` seed scripts running in name order.

=== "`springboot-redis`"

    `src/05-compose/springboot-redis/` — [lab page](labs/springboot-redis.md)
    · [visits app](labs/springboot-redis-visits.md)

    The capstone: multi-stage jar build, `depends_on`, a custom bridge, and
    the app reaching Redis by **service name** — everything from lessons 2–4
    in one file.

    ```bash
    cd src/05-compose/springboot-redis/visits
    docker compose up --build   # http://localhost:8080/
    ```

---

## Check yourself

<quiz>
In a compose file with services `web` and `db`, how does `web` reach postgres?
- [ ] Via localhost:5432
- [x] Via the service name `db` — Compose's embedded DNS resolves it on the shared bridge network
- [ ] Via the container's raw IP from docker inspect
- [ ] It can't without an overlay network
</quiz>

<quiz>
`depends_on` alone guarantees...
- [ ] The dependency is healthy and ready to accept connections
- [x] Only start order — pair it with a healthcheck + `condition: service_healthy` for readiness
- [ ] Restart on failure
- [ ] Network connectivity
</quiz>

<quiz>
`docker compose down` removes the containers. Your postgres data survives because it's in a [[named volume]] — to wipe it you'd run [[docker compose down -v]]
</quiz>

<quiz>
Which volume line keeps the container's node_modules from being clobbered by a host bind mount of `.:/app`?
- [ ] `- .:/app/node_modules`
- [x] `- /app/node_modules` (anonymous volume shadows the bind inside the container)
- [ ] `- node_modules:/app` 
- [ ] `- /app:/app/node_modules`
</quiz>

**Next:** [6. Command Lifecycle Reference](06-command-lifecycle.md)
