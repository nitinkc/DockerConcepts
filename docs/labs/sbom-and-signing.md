# Lab: SBOM + Image Signing

**Lesson:** [07 — Supply-Chain Security](../07-supply-chain-security.md)

**Goal:** Produce the two artifacts that make an image auditable — an SBOM
(*what's inside*) and a cosign signature (*who built it*).

## Tasks

Work through `src/07-supply-chain/sbom-signing/commands.sh` (solution in
`solution/commands.sh`):

1. `syft` → CycloneDX SBOM; count components (distroless ≈ 3 packages)
2. Push the image to a registry (signatures need digests, not local tags)
3. `cosign sign` — keyless OIDC flow, no key management
4. `cosign verify` — what an admission controller does in-cluster

## Verify

- SBOM is valid CycloneDX/SPDX JSON
- `cosign verify` returns the issuer + identity you expected
- You can explain why signing happens on **digests**: a tag is a mutable
  pointer; the signature binds to content

## The loop

```
build → sbom → scan → sign → push → registry → admission verify → run
```

Every phase of this course plugs into it: the CI pipeline owns the left
half; Phase-6 policy-as-code owns `admission verify`.
