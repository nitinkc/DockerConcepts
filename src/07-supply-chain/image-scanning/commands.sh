#!/usr/bin/env bash
# Lab: scan an image, read the report, gate on severity.
# Fill the TODOs; compare with solution/commands.sh

set -euo pipefail

# Install: brew install trivy   (or run the aquasec/trivy image)

# TODO 1: scan the alpine comparison image for HIGH+CRITICAL OS+library vulns
# trivy image --severity ...,... alpine-app

# TODO 2: scan the distroless image the same way — compare the count

# TODO 3: turn the scan into a pipeline gate — non-zero exit on CRITICAL
# trivy image --severity CRITICAL --exit-code ... distroless-app

# TODO 4: scan the repo itself (filesystem) for secrets/misconfig
# trivy fs --scanners ...,... .
