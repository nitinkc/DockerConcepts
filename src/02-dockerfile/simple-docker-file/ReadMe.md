# Lab: Simple Dockerfile (Java)

**Lesson:** [02 — Dockerfile & Image Construction](https://github.com/nitinkc/DockerConcepts/blob/main/docs/02-dockerfile-images.md)

Covers: `FROM`, `COPY`, `WORKDIR`, `RUN`, `CMD`, and overriding `CMD` at runtime.

## Build

```shell
cd src/02-dockerfile/simple-docker-file
docker build -t nitinkc/simple-java-commandline-app .
```

## Run

```shell
# Runs the default CMD -> Calculator add 5 3
docker run --rm --name=simple_javaapp nitinkc/simple-java-commandline-app

# Override CMD at runtime -> runs HelloWorld instead
docker run --rm nitinkc/simple-java-commandline-app java HelloWorld

# Pass different args to Calculator (ops: add, sub, mult, div)
docker run --rm nitinkc/simple-java-commandline-app java Calculator mult 6 7
```

## Cleanup

```shell
docker rm simple_javaapp 2>/dev/null
docker rmi nitinkc/simple-java-commandline-app
```

## Practice from memory

1. `mv Dockerfile Dockerfile.solution`, then rewrite `Dockerfile` from scratch —
   `FROM`, `COPY`, `WORKDIR`, `RUN javac`, `CMD`.
2. Build and run it; `diff Dockerfile Dockerfile.solution`.
3. Explain out loud why only **one** `CMD` can be active per Dockerfile.
