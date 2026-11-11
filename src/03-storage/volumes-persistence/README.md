# Lab: Storage & Data Persistence

**Lesson:** [03 — Storage & Data Persistence](https://github.com/nitinkc/DockerConcepts/blob/main/docs/03-storage-persistence.md)

**Goal:** Internalize the three storage options by breaking things:

| Mount | Backed by | Survives `docker rm`? | Best for |
|---|---|---|---|
| *(container layer)* | copy-on-write layer | No | disposable app state |
| **named volume** | `/var/lib/docker/volumes/` | Yes | databases, shared state |
| **bind mount** | arbitrary host path | Yes (host-owned) | live-editing source code |
| **tmpfs** | host RAM | No (gone on stop) | secrets, scratch data |

## Tasks

Work through `commands.sh` (8 TODOs). The deliberate sequence:

1. Prove a plain container **loses** its postgres data on `rm`
2. Prove a **named volume** keeps it
3. Prove a **bind mount** reflects host edits instantly
4. Prove **tmpfs** never hits disk

## Verify

- `SELECT * FROM t` fails on a fresh no-volume container, succeeds after volume remount
- `curl localhost:8080` shows your HTML edits without rebuilding anything
- The tmpfs file is absent on container restart

!!! tip "Muscle memory"
    The flag is the same `-v` for volumes and binds — the difference is the
    *source*: a bare name (`pgdata`) is a named volume; a path (`$PWD/site`) is
    a bind mount. Prefer the explicit `--mount type=...` syntax when it matters.

Compare with `solution/commands.sh`.
