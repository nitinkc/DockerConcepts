#!/usr/bin/env bash
# Lab: Storage & Data Persistence — fill in each TODO before running.
# Check solution/commands.sh only AFTER attempting each command yourself.

# --- Part 1: the default CoW layer is disposable ---

# TODO(1): Run a postgres:16-alpine container named "pg-nowrite" with
#         POSTGRES_PASSWORD=dev (no volume). Exec in, create table+row:
#         docker exec -it pg-nowrite psql -U postgres -c "CREATE TABLE t(i int); INSERT INTO t VALUES (42);"
# TODO(2): docker rm -f it, start a fresh one, query t -> table does not exist.

# --- Part 2: named volume survives container death ---

# TODO(3): Create a named volume "pgdata" (docker volume create)

# TODO(4): Run "pg-vol" postgres:16-alpine mounting the volume at
#         /var/lib/postgresql/data with POSTGRES_PASSWORD=dev

# TODO(5): Insert a row into table t, rm -f the container, start a new one on
#         the same volume, and SELECT the row back.

# --- Part 3: bind mount for live-editing source ---

# TODO(6): Serve ./site with nginx via a BIND MOUNT at /usr/share/nginx/html,
#         published on host port 8080. (hint: -v "$PWD/site:/usr/share/nginx/html")

# TODO(7): Edit site/index.html on the host, curl localhost:8080 again — change
#         is instant, no rebuild.

# --- Part 4: tmpfs (memory-only) ---

# TODO(8): Run alpine with a tmpfs at /secrets; write a file there, exit,
#         and confirm it is gone (it never touches disk).

# Cleanup
# docker rm -f pg-nowrite pg-vol site-dev tmpfs-demo 2>/dev/null
# docker volume rm pgdata 2>/dev/null
