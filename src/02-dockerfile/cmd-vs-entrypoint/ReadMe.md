# Lab: CMD vs ENTRYPOINT

**Lesson:** [02 — Dockerfile & Image Construction](https://github.com/nitinkc/DockerConcepts/blob/main/docs/02-dockerfile-images.md#cmd-vs-entrypoint)

- `ENTRYPOINT` = the executable that **always** runs when the container starts
- `CMD` = the **default arguments** handed to `ENTRYPOINT` — replaced entirely
  by whatever you pass after the image name in `docker run`

Look at `Dockerfile`:

```dockerfile
FROM busybox
ENTRYPOINT ["echo", "Hello, ENTRYPOINT! - always runs"]
CMD ["Hello, CMD! - this can be overridden"]
```

## Build & run

```shell
cd src/02-dockerfile/cmd-vs-entrypoint
docker build -t nitinkc/simple-docker-test .

# Both ENTRYPOINT and CMD execute
docker run --rm nitinkc/simple-docker-test
```

## Override CMD

Whatever you type after the image name **replaces** `CMD` — `ENTRYPOINT` stays:

```shell
docker run --rm nitinkc/simple-docker-test "overridden CMD args"
# -> runs: echo "Hello, ENTRYPOINT! - always runs" "overridden CMD args"
```

## Start an existing container

```shell
docker start docker-test        # then check logs
docker logs docker-test
```

(or Docker Desktop → Containers → select container → Logs)

## Practice from memory

1. Predict before running: `docker run --rm nitinkc/simple-docker-test foo bar`
   — which parts print, and why?
2. Rewrite the Dockerfile from scratch, then try `--entrypoint` at runtime:
   `docker run --rm --entrypoint ls nitinkc/simple-docker-test` — what happens
   to both `ENTRYPOINT` and `CMD`?
