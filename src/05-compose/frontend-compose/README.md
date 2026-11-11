# Lab: Frontend Dev with Docker Compose (bind-mount live reload)

**Lesson:** [05 — Docker Compose](https://github.com/nitinkc/DockerConcepts/blob/main/docs/05-docker-compose.md) · [03 — Storage](https://github.com/nitinkc/DockerConcepts/blob/main/docs/03-storage-persistence.md)

A React dev server containerized with a **bind mount** — edit source on the
host, the container sees changes instantly (the classic hot-reload pattern).

`docker-compose.yml`:

- `build.dockerfile: Dockerfile.dev` — dev image (node toolchain inside)
- `volumes: [".:/app", "/app/node_modules"]` — bind-mount source; the anonymous
  volume `/app/node_modules` shields container `node_modules` from being
  overwritten by the host's empty one
- `.env` → `CHOKIDAR_USEPOLLING=true` so file watching works inside the container

## Run

```shell
cd src/05-compose/frontend-compose
docker compose up --build      # image: nitinkc/simple-react-frontend:latest
# open http://localhost:3000, edit src/App.js, watch it hot-reload

docker compose down
```

## Push

```shell
docker push nitinkc/simple-react-frontend:latest
```

## Practice from memory

1. Rewrite `docker-compose.yml` from scratch (5 lines of service config suffice).
2. Explain why **both** `".:/app"` and `/app/node_modules` are needed — what
   breaks if you drop the second volume?
3. Convert the same setup to a named volume for `node_modules`.

---

<details>
<summary>Create React App reference (original README)</summary>

This project was bootstrapped with [Create React App](https://github.com/facebook/create-react-app).

```shell
rm -rf node_modules
rm -f package-lock.json
npm cache clean --force
npm install
npm start
```

### `npm start` — dev mode at [http://localhost:3000](http://localhost:3000)
### `npm test` — interactive watch mode
### `npm run build` — production bundle in `build/`
### `npm run eject` — one-way; copies configs/deps into the project

More: [CRA docs](https://facebook.github.io/create-react-app/docs/getting-started) · [React docs](https://reactjs.org/)
</details>
