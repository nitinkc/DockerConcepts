# Lab: ARG vs ENV

**Lesson:** [02 — Dockerfile & Image Construction](https://github.com/nitinkc/DockerConcepts/blob/main/docs/02-dockerfile-images.md#arg-vs-env)

**Goal:** Feel the difference between a **build-time** variable (`ARG`) and a
**runtime** variable (`ENV`).

## Tasks

Complete `Dockerfile` (6 TODOs) so that:

- `VERSION` can be overridden at build time with `--build-arg`
- `GREETING` can be overridden at runtime with `-e`
- `VERSION` is also visible at runtime — but only because you promoted it into `APP_VERSION`

## Build & run

```bash
cd src/02-dockerfile/args-vs-env
docker build -t argenv .
docker build --build-arg VERSION=1.2.3 -t argenv:1.2.3 .

docker run --rm argenv
docker run --rm -e GREETING=namaste argenv:1.2.3
```

## Verify

| Run | GREETING | APP_VERSION | VERSION |
|---|---|---|---|
| `docker run --rm argenv` | `hello` | `dev` | *(empty)* |
| `docker run --rm argenv:1.2.3` | `hello` | `1.2.3` | *(empty)* |
| `docker run --rm -e GREETING=namaste argenv:1.2.3` | `namaste` | `1.2.3` | *(empty)* |

The empty `VERSION` line is the whole point: **`ARG` is build-only and is gone
at runtime** unless copied into an `ENV`.

!!! warning "Secret note"
    `--build-arg` values are baked into image history (`docker history` shows
    them). Never pass real secrets via ARG — use BuildKit `--secret` mounts.

Compare your file with `solution/Dockerfile`.
