# Lab: Simple Node Backend

**Lesson:** [02 — Dockerfile & Image Construction](https://github.com/nitinkc/DockerConcepts/blob/main/docs/02-dockerfile-images.md)

For a Node app, `npm install` can happen **inside** the image build — the host
doesn't need Node at all.

`Dockerfile` walkthrough: `FROM` → `WORKDIR` → `COPY package.json` →
`RUN npm install` → `COPY . .` → `CMD ["npm","start"]`

> Copying `package.json` **before** the source is deliberate: `npm install`'s
> layer is cached until dependencies change — editing `index.js` doesn't
> re-trigger a full install.

## Build the image

```shell
cd src/02-dockerfile/simple-node-backend
docker build -t nitinkc/simple-node-backend:latest .
```

## Run it as a container

```shell
# -d detached, --publish host_port:container_port
docker run --name simple_nodeapp -d --publish 8080:3000 nitinkc/simple-node-backend

curl localhost:8080          # Express Server UP and RUNNING !!
curl localhost:8080/health   # Health is OK!!
```

## Stop / start

```shell
docker stop simple_nodeapp
docker start simple_nodeapp
docker rm simple_nodeapp     # after stopping
```

## Practice from memory

1. Rebuild the Dockerfile from scratch — pay attention to the **order** of the
   two `COPY` instructions and say why it matters for layer caching.
2. Add `EXPOSE 3000`, rebuild, and run `docker ps` — notice the PORTS column
   still needs `-p` to actually publish.
