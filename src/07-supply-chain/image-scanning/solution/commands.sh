#!/usr/bin/env bash
set -euo pipefail

# 1. Baseline scan — alpine image
trivy image --severity HIGH,CRITICAL alpine-app

# 2. Same scan on distroless — dramatically fewer findings
#    (no OS packages, nothing to report)
trivy image --severity HIGH,CRITICAL distroless-app

# 3. Gate: fail the pipeline on any CRITICAL vuln
trivy image --severity CRITICAL --exit-code 1 --ignore-unfixed distroless-app

# 4. Repo scan: secrets + misconfig (never commit what this finds)
trivy fs --scanners secret,misconfig .

# Reading the report:
#   Library / PkgName / Installed / Fixed Version / Severity / Title
# Fix strategy: rebuild on a patched base (bump the FROM tag) — NOT
# whitelisting. --ignore-unfixed skips vulns with no patch available.
