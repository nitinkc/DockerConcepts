# DockerConcepts

Hands-on Docker course: lessons in `docs/` (built with MkDocs Material) paired
with labs in `src/` you complete yourself.

- **Site:** <https://nitinkc.github.io/DockerConcepts/>
- **Lessons:** `docs/` — start at `docs/index.md` for the learning path
- **Labs:** `src/` grouped by lesson:
  - `01-fundamentals/container-internals`
  - `02-dockerfile/` — `simple-docker-file`, `cmd-vs-entrypoint`,
    `simple-node-backend`, `args-vs-env`, `multi-stage-build`
  - `03-storage/volumes-persistence`
  - `04-networking/bridge-dns-lab`
  - `05-compose/` — `frontend-compose`, `compose-db`, `springboot-redis`

Labs are either skeleton files (`# TODO` → compare with `solution/`) or working
examples with a *Practice from memory* section.

## Docs site

```shell
uv venv
source .venv/bin/activate
uv pip install -r requirements.txt --system-certs
mkdocs build     # output in site/
mkdocs serve     # http://localhost:8000
```

## Cleaning

```shell
docker builder prune --all
docker system prune -a --volumes   # heavier cleanup
```

## Misc Docker commands

### Make a docker container running Linux and login
```shell
docker run -it centos bash
```

### Install docker into the recently built container
```shell
curl -sSL https://get.docker.com/ | sh
```
