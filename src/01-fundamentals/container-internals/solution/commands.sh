#!/usr/bin/env bash

# (1) detached sleeper
docker run -d --name lab-sleeper alpine sleep 3600

# (2) process tree inside the container — `sleep 3600` is PID 1
docker exec lab-sleeper ps aux

# (3) the same process is an ordinary PID on the host (Docker Desktop: the VM)
docker inspect -f '{{.State.Pid}}' lab-sleeper

# (4) kernel namespaces — mnt, net, pid, ipc, uts, user, cgroup
docker run --rm --privileged --pid=host alpine ls -l /proc/1/ns

# (5) with --pid=host the container sees the whole host(VM) process tree
docker run --rm --pid=host alpine ps aux | head

# (6) cgroups resource caps + live accounting
docker run -d --name lab-limited --memory=64m --cpus=0.5 alpine sleep 3600
docker stats lab-limited --no-stream

# (7) immutable layers
docker history alpine
docker image inspect alpine -f '{{json .RootFS.Layers}}'

# (8) engine architecture: CLI -> dockerd -> containerd -> runc
docker version
docker info --format 'Storage: {{.Driver}} | Runtimes: {{.Runtimes}}'

# cleanup
docker rm -f lab-sleeper lab-limited
