#!/usr/bin/env bash
# Lab: Container Internals — fill in each TODO before running.
# Check solution/commands.sh only AFTER attempting each command yourself.

# TODO(1): Run a detached alpine container named "lab-sleeper" running `sleep 3600`
# docker run ...

# TODO(2): Show the process tree INSIDE the container (hint: docker exec ... ps aux).
#         What is PID 1?

# TODO(3): Show the same container's process from the HOST side.
#         (hint: docker exec won't help — use docker inspect -f '{{.State.Pid}}' lab-sleeper)

# TODO(4): List the kernel namespaces of a process inside a privileged container:
#         docker run --rm --privileged --pid=host alpine ls -l /proc/1/ns
#         (try writing it from memory first)

# TODO(5): Re-run `ps aux` inside a container launched with --pid=host.
#         What changed?

# TODO(6): Run a container named "lab-limited" capped at 64MiB RAM and half a CPU,
#         sleeping 3600, then stream its live usage with docker stats.

# TODO(7): Show the layer stack of the alpine image (hint: docker history).
#         Then inspect the layer digests with docker image inspect.

# TODO(8): Show client/server split and storage driver (hint: docker version, docker info).

# Cleanup
# docker rm -f lab-sleeper lab-limited
