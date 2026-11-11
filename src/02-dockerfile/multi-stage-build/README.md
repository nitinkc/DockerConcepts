# Lab: Multi-Stage Builds & Layer Optimization

**Lesson:** [02 — Dockerfile & Image Construction](https://github.com/nitinkc/DockerConcepts/blob/main/docs/02-dockerfile-images.md#multi-stage-builds--layer-optimization)

**Goal:** Ship a ~15 MB runtime image instead of a ~300 MB toolchain image.
The Go SDK is needed to *compile* the binary — never to *run* it.

## Tasks

Complete the 7 TODOs in `Dockerfile`. The file has two stages:

1. **builder** — `golang:1.22-alpine`, compiles `main.go` into a static binary
2. **runtime** — `alpine:3.19`, receives *only* the binary via `COPY --from=builder`

## Build & run

```bash
cd src/02-dockerfile/multi-stage-build
docker build -t multi-stage-app .
docker run --rm -d --name msa -p 8080:8080 multi-stage-app
curl localhost:8080
docker rm -f msa
```

## Verify

```bash
docker images multi-stage-app        # should be ~15-20 MB, not hundreds of MB
docker history multi-stage-app       # final image contains no Go toolchain layers
```

!!! tip "Why CGO_ENABLED=0?"
    It produces a fully static binary, so the alpine stage needs no libc or
    runtime dependencies — the binary *is* the entire app.

Compare with `solution/Dockerfile`. Then try the same pattern yourself on the
Spring Boot app in `../../05-compose/springboot-redis/visits/Dockerfile`.
