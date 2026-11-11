# Lab: SBOM + Image Signing

Two halves of provenance: *what's inside* (SBOM) and *who built it*
(signature).

## Tasks

Work through `commands.sh` TODOs (solution in `solution/commands.sh`).

## What to notice

- `syft` output on a distroless image is nearly empty — the SBOM *is* the
  payoff of the small-image work from the previous labs.
- `cosign sign` works on **digests**, not tags — signing `app:latest`
  signs whatever that tag points at *right now*. This is why pipelines tag
  by SHA and sign the resulting digest.
- Keyless signing trades "manage keys forever" for "trust an OIDC identity."
  In CI the OIDC identity is the pipeline itself — the signature proves
  *this image came from your pipeline*, which is exactly what admission
  policies verify.

## Practice from memory

Explain the full loop in one breath: build → SBOM → scan → sign → registry
→ admission verify → run. Which step detects CVEs? Which step detects
tampering?
