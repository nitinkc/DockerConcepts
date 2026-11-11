# Lab: Distroless Images

**Lesson:** [07 — Supply-Chain Security](../07-supply-chain-security.md)

**Goal:** Ship a ~2 MB image with no shell — then feel what "no attack
surface" means when `docker exec` fails.

## Tasks

Complete the 3 TODOs in `src/07-supply-chain/distroless/Dockerfile`:

1. Build stage: `golang:1.22-alpine`, static binary (`CGO_ENABLED=0`)
2. Runtime stage: `gcr.io/distroless/static:nonroot`
3. `COPY --from` the binary, `USER nonroot`, `ENTRYPOINT`

## Build & run

```bash
cd src/07-supply-chain/distroless
docker build -t distroless-app .
docker run --rm -d --name d -p 8080:8080 distroless-app
curl localhost:8080            # hello from a ~2MB image
docker exec -it d sh           # ← fails. That's the point.
docker rm -f d
```

## Verify

```bash
docker images distroless-app       # < 5 MB
docker history distroless-app      # zero OS package layers
```

Compare with `solution/Dockerfile`. Bonus: run the same build on
`../../02-dockerfile/multi-stage-build` and diff `docker images` sizes —
you just quantified attack surface.
