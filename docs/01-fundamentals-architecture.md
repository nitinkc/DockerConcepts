---
quiz:
  enabled: true
---

# 1. Fundamentals & Architecture

## What is a container?

A container is **not** a lightweight Virtual Machine.

- **Virtual Machine** — virtualizes the *hardware*; runs a full guest OS kernel
  and drivers on top of a hypervisor.
- **Container** — virtualizes the *OS kernel*; it is a standard host process
  running inside an isolated sandbox. It starts in milliseconds because there
  is no OS to boot.

## Kernel isolation primitives

Containers exist because of two Linux kernel mechanisms:

### Namespaces — visibility / boundary isolation

Each container gets its own copy of global resources:

| Namespace | Isolates |
|---|---|
| `pid` | Process tree — container PID 1 maps to an unprivileged PID on the host |
| `net` | Network interfaces, routing tables, port bindings |
| `mnt` | Mount points and the root filesystem `/` |
| `ipc` | Inter-process communication and shared memory |
| `uts` | Hostname and NIS domain name |
| `user` | UID/GID mapping between host and container |

### Control groups (`cgroups`) — resource limits

Limits and accounts for CPU, memory, disk I/O, and max PIDs. This is what makes
`docker run --memory=64m --cpus=0.5` enforceable.

## Docker Engine architecture

```
docker (CLI)  --REST API-->  dockerd (daemon)  -->  containerd  -->  runc
                                                                  |
                                            configures namespaces + cgroups,
                                            launches the container process
```

- **`docker` CLI** — client; issues REST API requests (works over sockets or TCP)
- **`dockerd`** — persistent daemon managing images, volumes, networks
- **`containerd` / `runc`** — OCI-compliant low-level runtimes that actually
  configure namespaces and exec the container process

## Image = stacked, immutable layers

An image is a pile of read-only layers (one per `RUN`/`COPY` instruction,
roughly). A running container adds **one thin writable layer** on top — the
copy-on-write layer. Containers sharing an image share every read-only layer,
which is why 50 containers from one image cost barely more disk than one.

---

## Lab: prove it

Do the **`container-internals`** lab — [lab page](labs/container-internals.md)
· `src/01-fundamentals/container-internals/`

You will watch PID 1 inside a container, list kernel namespaces, cap memory with
cgroups and see the limit in `docker stats`, and inspect image layers with
`docker history`.

```bash
cd src/01-fundamentals/container-internals   # fill in commands.sh TODOs
```

---

## Check yourself

<quiz>
What makes a container different from a VM?
- [ ] It virtualizes the hardware and boots a guest kernel
- [x] It is a normal host process isolated by namespaces and limited by cgroups
- [ ] It runs on a hypervisor with a minimal kernel
- [ ] It emulates syscalls through a translation layer
</quiz>

<quiz>
Which namespace isolates the container's port bindings and routing table?
- [ ] `mnt`
- [ ] `uts`
- [x] `net`
- [ ] `ipc`
</quiz>

<quiz>
`docker run --memory=64m` is enforced by [[cgroups]]
</quiz>

<quiz>
When two containers run from the same image, which layers do they share?
- [x] All read-only image layers
- [ ] All layers including the writable layer
- [ ] Only the base OS layer
- [ ] None — each gets a private copy
</quiz>

**Next:** [2. Dockerfile & Image Construction](02-dockerfile-images.md)
