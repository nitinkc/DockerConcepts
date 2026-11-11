---
quiz:
  enabled: true
---

# 2. Dockerfile & Image Construction

An image is stacked, immutable, read-only layers. Each `FROM`, `COPY`, and `RUN`
roughly appends one layer; the **order of instructions controls cache reuse**.

## Key instructions

| Instruction | What it does | Layer? |
|---|---|---|
| `FROM` | Sets the base parent image (`alpine:3.19`, `node:20-slim`) | base |
| `WORKDIR` | Working directory for subsequent instructions | cheap |
| `COPY` | Copies local build-context files into the image | yes |
| `ADD` | Like `COPY` + can extract tarballs and fetch remote URLs | yes |
| `RUN` | Executes a build-time command (each call = new layer) | yes |
| `ARG` | Build-time variable, `--build-arg` — **gone at runtime** | metadata |
| `ENV` | Runtime environment variable — persists into the container | metadata |
| `EXPOSE` | Documents intended ports — does **not** publish them | metadata |
| `CMD` | Default args for `ENTRYPOINT`; overridable at `docker run` | metadata |
| `ENTRYPOINT` | The executable always invoked at container start | metadata |

!!! tip "`COPY` vs `ADD`"
    Default to `COPY` — predictable. Reach for `ADD` only when you actually want
    remote-URL fetch or auto tar extraction.

### ARG vs ENV

- `ARG` exists **only during `docker build`** — override with `--build-arg`.
  It never reaches the running container unless you promote it: `ENV X=$ARG`.
- `ENV` persists into the container — override with `docker run -e`.
- `--build-arg` values are visible in `docker history` — never use them for secrets.

### CMD vs ENTRYPOINT

```dockerfile
ENTRYPOINT ["echo", "always runs"]
CMD ["default arg — replaceable"]
```

`docker run img "new args"` **replaces `CMD` entirely**; `ENTRYPOINT` stays
(unless `--entrypoint` is passed). Only the last `CMD` in a Dockerfile counts.

## Layer caching & ordering

BuildKit reuses a layer only if the instruction **and everything above it** is
unchanged. Put the things that change least first:

```dockerfile
COPY ./package.json ./     # changes rarely
RUN npm install            # cached until package.json changes
COPY ./ ./                 # source changes often -> invalidates only these layers
```

## Multi-stage builds & optimization

Build with the fat toolchain image; ship only the artifact to a minimal runtime:

```dockerfile
# Stage 1: Build binary
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.* ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o myapp

# Stage 2: Minimal runtime image
FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/myapp .
EXPOSE 8080
ENTRYPOINT ["./myapp"]
```

`COPY --from=builder` is the magic — the final image carries *only* the binary.
Same pattern works for Gradle → jar, `npm run build` → static files, etc.

---

## Labs — do them in order

=== "`simple-docker-file`"

    `src/02-dockerfile/simple-docker-file/` — [lab page](labs/simple-docker-file.md)

    `FROM`, `COPY`, `WORKDIR`, `RUN`, `CMD`, and overriding `CMD` from `docker run`.

    ```bash
    cd src/02-dockerfile/simple-docker-file
    docker build -t nitinkc/simple-java-commandline-app .
    docker run --rm nitinkc/simple-java-commandline-app
    ```

=== "`cmd-vs-entrypoint`"

    `src/02-dockerfile/cmd-vs-entrypoint/` — [lab page](labs/cmd-vs-entrypoint.md)

    Watch `CMD` get replaced while `ENTRYPOINT` always executes.

    ```bash
    docker run --rm nitinkc/simple-docker-test "overridden args"
    ```

=== "`simple-node-backend`"

    `src/02-dockerfile/simple-node-backend/` — [lab page](labs/simple-node-backend.md)

    Layer-cache-friendly `npm` Dockerfile + `-p 8080:3000` port publishing.

=== "`args-vs-env`"

    `src/02-dockerfile/args-vs-env/` — [lab page](labs/args-vs-env.md)

    **Skeleton lab.** Fill the 6 TODOs; prove `ARG` dies at runtime unless
    promoted into `ENV`.

=== "`multi-stage-build`"

    `src/02-dockerfile/multi-stage-build/` — [lab page](labs/multi-stage-build.md)

    **Skeleton lab.** Write the two-stage Go Dockerfile (7 TODOs), compare
    image sizes with `docker images`.

---

## Check yourself

<quiz>
Which instruction copies local files AND can auto-extract tarballs/fetch URLs?
- [ ] `COPY`
- [x] `ADD`
- [ ] `RUN`
- [ ] `IMPORT`
</quiz>

<quiz>
You run `docker run --build-arg VERSION=2.0`. Why does `echo $VERSION` print nothing inside the running container?
- [ ] The flag only works with `docker build`
- [ ] VERSION was never exported to the shell
- [x] ARG is build-time only — it must be copied into an ENV to persist
- [ ] BusyBox doesn't support environment variables
</quiz>

<quiz>
`docker run myimg foo bar` on an image with `ENTRYPOINT ["python"]` and `CMD ["app.py"]` executes [[python foo bar]]
</quiz>

<quiz>
Why copy `package.json` before `COPY ./ ./` in a Node Dockerfile?
- [x] So `npm install`'s layer stays cached when only source files change
- [ ] package.json must exist before WORKDIR
- [ ] Docker requires alphabetical COPY order
- [ ] It reduces image size
</quiz>

<quiz>
In a multi-stage build, what does `COPY --from=builder /app/myapp .` do?
- [ ] Copies from the previous Dockerfile stage's output filesystem
- [x] Copies a file out of the named earlier stage into the current stage
- [ ] Mounts the builder stage at runtime
- [ ] Creates a symlink to the builder image
</quiz>

**Next:** [3. Storage & Data Persistence](03-storage-persistence.md)
