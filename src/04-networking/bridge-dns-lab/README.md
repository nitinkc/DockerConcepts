# Lab: Bridge Networking & DNS Discovery

**Lesson:** [04 — Docker Networking](https://github.com/nitinkc/DockerConcepts/blob/main/docs/04-networking.md)

**Goal:** Feel the three facts that trip everyone up:

1. The **default `docker0` bridge has no DNS** — containers can only reach each
   other by raw IP
2. A **user-defined bridge** gives you the embedded resolver `127.0.0.11` —
   containers ping each other by name
3. **`EXPOSE` is documentation; `-p` is the actual host port forward**

## Tasks

Work through `commands.sh` (10 TODOs) in four parts:

| Part | You prove |
|---|---|
| 1 | `ping <ip>` works on default bridge, `ping <name>` fails |
| 2 | `lab-net` resolves names via `127.0.0.11` |
| 3 | no `-p` ⇒ unreachable from host; `-p 8080:80` ⇒ DNAT works |
| 4 | `--network none` leaves only `lo` |

## Verify

```bash
docker exec u1 cat /etc/resolv.conf    # nameserver 127.0.0.11
docker network inspect lab-net         # subnet, gateway, container map
curl localhost:8080                    # only works for the -p container
```

!!! tip "Rule of thumb"
    **Always create a user-defined network for real apps.** You get DNS service
    discovery, isolation between networks, and clean attach/detach — the default
    bridge gives you none of that.

Compare with `solution/commands.sh`.
