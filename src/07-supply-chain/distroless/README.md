# Lab: Distroless Images

Rebuild the same Go service twice — once on `alpine`, once on
`gcr.io/distroless/static` — and measure the difference.

## Tasks

Fill the 3 TODOs in `Dockerfile`, then:

```bash
docker build -t distroless-app .
docker build -f ../../02-dockerfile/multi-stage-build/Dockerfile \
  -t alpine-app ../../02-dockerfile/multi-stage-build   # comparison build
docker images --format '{{.Repository}}: {{.Size}}'
```

## The moment that teaches the lesson

```bash
docker run --rm -d --name d -p 8080:8080 distroless-app
curl localhost:8080                  # works

docker exec -it d sh                 # FAIL — there is no shell
docker rm -f d
```

`exec` failing is the feature: an attacker who lands code exec in your
container gets the same nothing. Debug with
`kubectl debug -it <pod> --image=busybox --target=<container>` instead.

## Verify

- Final image < 5 MB (vs ~15–20 MB alpine, ~300 MB+ debian)
- `docker history distroless-app` shows no OS package layers
- You can explain the debug trade-off in one sentence
