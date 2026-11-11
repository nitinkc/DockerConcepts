---
quiz:
  enabled: true
---

# 6. Command Lifecycle Reference

The cheat sheet for every lab. Type these until they're reflexes.

## Images

```bash
docker build -t app:v1 .        # build, tagging name:version
docker images                   # list local images
docker history app:v1           # show the layer stack
docker rmi app:v1               # remove image
docker pull nginx:alpine        # fetch without running
```

## Containers

```bash
docker run -d --name my-app -p 80:80 app:v1   # create + start detached
docker ps                     # running only
docker ps -a                  # include stopped
docker logs -f my-app         # stream logs
docker exec -it my-app sh     # shell inside a running container
docker inspect my-app         # full JSON (PID, IP, mounts, env)
docker stop my-app            # SIGTERM, then SIGKILL after grace
docker start my-app           # restart a stopped container
docker restart my-app         # stop + start
docker rm my-app              # remove (needs -f if running)
docker cp my-app:/file .      # copy out of a container
```

## Networks

```bash
docker network ls
docker network create my-net
docker network inspect my-net           # subnet, gateway, container map
docker network connect my-net my-app    # attach a running container
docker network disconnect my-net my-app
docker network rm my-net
```

## Volumes & storage

```bash
docker volume ls
docker volume create pgdata
docker volume inspect pgdata
docker volume rm pgdata
docker run -v pgdata:/data app          # named volume
docker run -v "$PWD/site:/srv" app      # bind mount
docker run --tmpfs /secrets app         # memory only
```

## Compose

```bash
docker compose up --build / -d
docker compose ps / logs -f / exec
docker compose down        # keeps volumes
docker compose down -v     # removes volumes too
```

## Cleanup

```bash
docker system df                  # disk usage breakdown
docker system prune               # stopped containers, unused nets, dangling images
docker system prune -a --volumes  # everything unused (careful)
docker builder prune --all        # build cache
```

---

## Check yourself

<quiz>
You need a shell inside a *running* container named `api`. The command is:
- [ ] `docker run -it api sh`
- [ ] `docker attach api sh`
- [x] `docker exec -it api sh`
- [ ] `docker ssh api`
</quiz>

<quiz>
`docker ps` shows nothing but you know a container exists. It's [[stopped]] — list it with [[docker ps -a]]
</quiz>

<quiz>
What does `docker logs -f` do that `docker logs` doesn't?
- [x] Follows the log stream live like tail -f
- [ ] Forces JSON output
- [ ] Shows only errors
- [ ] Fetches logs from the registry
</quiz>

<quiz>
`docker system prune -a` removes all unused images. What flag also removes unused volumes?
- [ ] `-v`
- [ ] `-f`
- [x] `--volumes`
- [ ] `--all-data`
</quiz>

---

Course complete — go redo the labs until you can write every Dockerfile,
compose file, and command **without looking at the solution**. That's the
muscle memory.
