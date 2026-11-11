# Docker Concepts — Hands-On Course

A learn-by-doing Docker course: short theory lessons paired with labs you
**type out yourself**. The goal is muscle memory — every lesson ends with code
you complete and commands you run.

## How the course works

- **`docs/`** (this site) — the lessons. Read a section, then do its lab.
- **`src/`** — the labs, grouped by lesson. Two flavors:
    - **Skeleton + solution** — files with `# TODO` blanks; fill them in, then
      compare with `solution/`
    - **Working code + practice tasks** — runnable examples with a
      *Practice from memory* section: rebuild key files from scratch and diff

!!! tip "The muscle-memory loop"
    Read → cover the solution → write it yourself → `diff` → explain it out
    loud. Repeat each lab until you can write the file without peeking.

## Learning path

| # | Lesson | Labs in `src/` |
|---|---|---|
| 1 | [Fundamentals & Architecture](01-fundamentals-architecture.md) | [`container-internals`](labs/container-internals.md) |
| 2 | [Dockerfile & Image Construction](02-dockerfile-images.md) | [`simple-docker-file`](labs/simple-docker-file.md) · [`cmd-vs-entrypoint`](labs/cmd-vs-entrypoint.md) · [`simple-node-backend`](labs/simple-node-backend.md) · [`args-vs-env`](labs/args-vs-env.md) · [`multi-stage-build`](labs/multi-stage-build.md) |
| 3 | [Storage & Data Persistence](03-storage-persistence.md) | [`volumes-persistence`](labs/volumes-persistence.md) |
| 4 | [Networking Deep Dive](04-networking.md) | [`bridge-dns-lab`](labs/bridge-dns-lab.md) |
| 5 | [Docker Compose](05-docker-compose.md) | [`frontend-compose`](labs/frontend-compose.md) · [`compose-db`](labs/compose-db.md) · [`springboot-redis`](labs/springboot-redis.md) |
| 6 | [Command Lifecycle Reference](06-command-lifecycle.md) | cheat sheet for all labs |

## Prerequisites

- Docker Desktop (or Docker Engine on Linux) — verify with `docker version`
- A terminal; `src/` labs assume you `cd` into the lab folder first
- For the Spring Boot lab only: nothing extra — the build runs inside Docker

## Repo layout

```
DockerConcepts/
├── docs/                    # these lessons (built with mkdocs + material)
└── src/
    ├── 01-fundamentals/     # kernel primitives: namespaces, cgroups, layers
    ├── 02-dockerfile/       # FROM..ENTRYPOINT, ARG/ENV, multi-stage
    ├── 03-storage/          # volumes, bind mounts, tmpfs
    ├── 04-networking/       # bridge drivers, embedded DNS, publish vs expose
    └── 05-compose/          # multi-service apps: react, postgres, spring+redis
```
