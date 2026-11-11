#!/usr/bin/env bash
# Lab: Bridge Networking & DNS — fill in each TODO before running.
# Check solution/commands.sh only AFTER attempting each command yourself.

# --- Part 1: the DEFAULT bridge has no DNS ---

# TODO(1): Run two alpine sleepers named "d1" and "d2" with NO --network flag.

# TODO(2): Find d2's IP (hint: docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' d2)

# TODO(3): From d1, ping d2 BY IP (works) then BY NAME "d2" (fails — why?)

# --- Part 2: user-defined bridge gives embedded DNS (127.0.0.11) ---

# TODO(4): Create a bridge network named "lab-net"

# TODO(5): Run sleepers "u1" and "u2" attached to lab-net

# TODO(6): From u1, ping u2 BY NAME (now works). Check the resolver:
#         docker exec u1 cat /etc/resolv.conf   -> nameserver 127.0.0.11

# --- Part 3: EXPOSE vs publish ---

# TODO(7): Run nginx as "web-exp" on lab-net WITHOUT -p. From u1, curl it by
#         name: docker exec u1 wget -qO- http://web-exp  (works internally)

# TODO(8): From the HOST, curl localhost:80 -> fails. Nothing is published.
#         Now run "web-pub" with -p 8080:80 and curl localhost:8080 -> works.

# --- Part 4: none & host drivers ---

# TODO(9): Run alpine with --network none and list its interfaces (only lo).

# TODO(10): Inspect lab-net: subnet, gateway, connected containers.

# Cleanup
# docker rm -f d1 d2 u1 u2 web-exp web-pub nonet 2>/dev/null
# docker network rm lab-net 2>/dev/null
