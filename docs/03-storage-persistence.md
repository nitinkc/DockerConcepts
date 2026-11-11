---
quiz:
  enabled: true
---

# 3. Storage & Data Persistence

By default, everything a container writes lands in its **copy-on-write (CoW)
container layer**. `docker rm` deletes that layer — and your data with it.

## The three storage options

### 1. Volumes — managed by Docker

```bash
docker volume create pgdata
docker run -d -v pgdata:/var/lib/postgresql/data postgres:16-alpine
```

- Stored under `/var/lib/docker/volumes/` on the host (or in the Docker Desktop VM)
- Survive `docker rm`; shareable across containers
- **Best practice for databases and any stateful workload**

### 2. Bind mounts — host-controlled path

```bash
docker run -d -p 8080:80 -v "$PWD/site:/usr/share/nginx/html" nginx:alpine
```

- Maps an arbitrary host file/dir into the container
- Host edits appear instantly — **the local-dev hot-reload pattern**
- The container can also write *back* to your host filesystem (be careful)

### 3. tmpfs — memory only

```bash
docker run --tmpfs /secrets alpine sh -c "echo token > /secrets/t"
```

- Never written to disk; destroyed on stop
- For secrets or scratch data that must not persist

## `-v` vs `--mount`

Same feature, different syntax. `-v name:/path` silently *creates* missing
sources; `--mount type=volume|bind|tmpfs,...` is explicit and fails loudly.
Reach for `--mount` in scripts you want to be safe.

```bash
docker run --mount type=bind,source="$PWD/site",target=/usr/share/nginx/html,readonly nginx:alpine
```

## Compose mapping

```yaml
services:
  web:
    volumes:
      - .:/app               # bind mount: live-reload source
      - /app/node_modules    # anonymous volume: protects container's modules
  db:
    volumes:
      - db_data:/var/lib/postgresql/data   # named volume

volumes:
  db_data:                   # declared at top level
```

!!! warning "Init scripts run once"
    Postgres entrypoint runs `/docker-entrypoint-initdb.d/*` **only when the
    data dir is empty**. Seeded a volume already? `docker compose down -v`
    wipes it before `up` will re-init.

---

## Lab

**`volumes-persistence`** — [lab page](labs/volumes-persistence.md)
· `src/03-storage/volumes-persistence/` (skeleton lab)

8 TODOs that prove each storage type by breaking it: lose postgres data on
`rm`, get it back with a named volume, live-edit HTML through a bind mount,
watch tmpfs evaporate.

```bash
cd src/03-storage/volumes-persistence   # fill in commands.sh TODOs
```

Bind mounts also show up again in `src/05-compose/frontend-compose` (React
hot-reload) and named volumes in `src/05-compose/compose-db`.

---

## Check yourself

<quiz>
A container writes a file, then you `docker rm` it. Where did the file live and what happened?
- [ ] In a volume — it survives
- [ ] In tmpfs — it survives until reboot
- [x] In the writable CoW container layer — deleted with the container
- [ ] In the image layer — it becomes a new image layer
</quiz>

<quiz>
For local development where host edits must appear inside the container instantly, use a [[bind]] mount
</quiz>

<quiz>
What does `-v pgdata:/var/lib/postgresql/data` create?
- [ ] A bind mount to a host folder named pgdata
- [x] A named Docker volume managed under /var/lib/docker/volumes
- [ ] A tmpfs mount
- [ ] A new image layer
</quiz>

<quiz>
Your postgres container was already started once. You add init scripts to /docker-entrypoint-initdb.d and restart — they don't run. Why?
- [x] Init scripts only execute when the data directory is empty (first boot)
- [ ] Scripts need +x and you forgot chmod
- [ ] docker restart skips the entrypoint
- [ ] The postgres user lacks permission
</quiz>

**Next:** [4. Networking Deep Dive](04-networking.md)
