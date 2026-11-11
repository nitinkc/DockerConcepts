# Lab: Image Scanning & Pipeline Gates

**Lesson:** [07 — Supply-Chain Security](../07-supply-chain-security.md)

**Goal:** Turn `trivy` output into a deploy decision — a gate that fails on
CRITICAL instead of a report nobody reads.

## Tasks

Work through `src/07-supply-chain/image-scanning/commands.sh` (solution in
`solution/commands.sh`):

1. Scan the alpine-based comparison image (`HIGH,CRITICAL`)
2. Scan the distroless image — compare finding counts
3. Add `--exit-code 1` + `--ignore-unfixed` → a real pipeline gate
4. Scan the repo filesystem for secrets/misconfig

## Verify

- You can read a finding row: `Library / Installed / Fixed Version /
  Severity / Title` — "Fixed Version" is your remediation path
- You understand `--ignore-unfixed` (don't gate on unpatched noise)
- One-sentence answer ready: "scan in CI, gate on CRITICAL, fix by
  re-basing on a patched base image"

!!! warning "Never whitelist the world"
    The failure mode of scanning is `.trivyignore` accumulating every
    finding. Whitelists are for *accepted risk with a date*, not cleanup.
