# Lab: Container Internals (Namespaces & cgroups)

**Lesson:** [01 — Fundamentals & Architecture](https://github.com/nitinkc/DockerConcepts/blob/main/docs/01-fundamentals-architecture.md)

**Goal:** Prove to yourself that a container is just an isolated Linux process —
not a VM — by inspecting PIDs, namespaces, and resource limits from the CLI.

## Tasks

Work through `commands.sh` line by line. Every step is a `# TODO` — write the
`docker` command yourself first, then check `solution/commands.sh`.

1. **PID 1** — show that the container's init process is just a normal process.
2. **Namespaces** — list the namespaces a container is isolated in.
3. **`--pid=host`** — remove PID isolation and see the difference.
4. **cgroups** — cap memory and CPU, watch it in `docker stats`.
5. **Layers** — prove images are stacked read-only layers with `docker history`.
6. **Engine** — see the daemon / containerd split with `docker version` + `docker info`.

## Run it

```bash
cd src/01-fundamentals/container-internals
# open commands.sh, fill in each TODO, then run the file line-by-line
```

## Verify

| Observation | Expected |
|---|---|
| `docker exec` into a `sleep` container, `ps aux` | single process tree, PID 1 = `sleep` |
| `ls /proc/1/ns` inside a privileged container | `mnt net pid ipc uts user cgroup` entries |
| `docker stats` with `--memory=64m` | MEM LIMIT column shows ~64MiB |
| `docker history` on any image | one row per Dockerfile instruction |

!!! tip "Docker Desktop note"
    On macOS/Windows, containers run inside a lightweight Linux VM. Commands like
    `--pid=host` or `/proc` inspection show the **VM's** kernel, not macOS — this
    is expected and still demonstrates the concept.

## Cleanup

```bash
docker rm -f lab-sleeper lab-limited 2>/dev/null
```
