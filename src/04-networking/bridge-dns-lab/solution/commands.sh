#!/usr/bin/env bash

# (1) two containers on the default bridge (docker0)
docker run -d --name d1 alpine sleep 3600
docker run -d --name d2 alpine sleep 3600

# (2) discover the IP — the only way to reach it on the default bridge
docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' d2

# (3) IP works, NAME fails — default docker0 has no embedded DNS
docker exec d1 ping -c 2 "$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' d2)"
docker exec d1 ping -c 2 d2        # ping: bad address 'd2'

# (4) user-defined bridge
docker network create lab-net

# (5) attach containers
docker run -d --name u1 --network lab-net alpine sleep 3600
docker run -d --name u2 --network lab-net alpine sleep 3600

# (6) DNS name resolution via the embedded resolver at 127.0.0.11
docker exec u1 ping -c 2 u2
docker exec u1 cat /etc/resolv.conf

# (7) EXPOSE is metadata — reachable network-internally, invisible to host
docker run -d --name web-exp --network lab-net nginx:alpine
docker exec u1 wget -qO- http://web-exp | head -5

# (8) -p host:container programs DNAT/iptables on the host
curl -s -o /dev/null -w '%{http_code}\n' localhost:80        # fails
docker run -d --name web-pub --network lab-net -p 8080:80 nginx:alpine
curl -s -o /dev/null -w '%{http_code}\n' localhost:8080      # 200

# (9) none driver — total isolation, loopback only
docker run -d --name nonet --network none alpine sleep 3600
docker exec nonet ip addr

# (10) inspect the bridge: subnet, gateway, container map
docker network inspect lab-net

# cleanup
docker rm -f d1 d2 u1 u2 web-exp web-pub nonet
docker network rm lab-net
