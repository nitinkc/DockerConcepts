# Supply-Chain Security: From Big Image to Verified Artifact

**Lesson 7** — the security half of images. Everything before this lesson
was about *building* images; this is about *proving they're safe*.

## Why this matters

A container image is a software supply chain artifact: base image +
dependencies + your code. Each layer can carry CVEs, secrets, or tampered
binaries. Modern pipelines don't just build images — they **minimize** them,
**scan** them, **inventory** them (SBOM), and **sign** them so deploys can
verify provenance.

## The four controls (memorize this ladder)

```
smaller attack surface  →  distroless/scratch runtime
know what's inside      →  SBOM (syft)
know what's vulnerable  →  scanner (trivy/grype) gating on severity
prove origin            →  signature + provenance (cosign, SLSA)
```

## 1. Distroless — remove everything that isn't your app

A `debian` base image ships a shell, package manager, and ~100 binaries an
attacker can use post-exploit. `gcr.io/distroless/static` ships *none* of
that — no shell means `kubectl exec` gives you nothing.

```dockerfile
FROM golang:1.22 AS build
RUN CGO_ENABLED=0 go build -o /app main.go

FROM gcr.io/distroless/static:nonroot   # ~2 MB, no shell, no package mgr
COPY --from=build /app /app
USER nonroot
ENTRYPOINT ["/app"]
```

Trade-off to be able to defend in an interview: you can't `docker exec sh`
into prod — debug via ephemeral debug containers or logs instead.

## 2. SBOM — the ingredient list

```bash
syft spring-app:local -o cyclonedx-json > sbom.json
```

An SBOM answers "what packages/versions are in this image" — required for
vuln tracking at scale, license audits, and incident response ("are we
running log4j anywhere?").

## 3. Scanning — gate on severity, not count

```bash
trivy image --severity HIGH,CRITICAL --exit-code 1 spring-app:local
```

`--exit-code 1` turns the scan into a **pipeline gate**. The discipline:
triage HIGH/CRITICAL, fix by rebuilding on a patched base — never by
whitelisting the world. Scanners also check IaC (`trivy config .`), repos
(`trivy fs .`), and secrets.

## 4. Signing — cosign keyless

```bash
cosign sign $IMAGE                 # keyless via Fulcio + OIDC identity
cosign verify $IMAGE --certificate-identity=... --certificate-oidc-issuer=...
```

A signature binds the image digest to *who built it*. In-cluster admission
(Phase 6: Kyverno/Gatekeeper) can then enforce "only run signed images from
our CI" — closing the supply chain loop.

## SLSA levels (the vocabulary for provenance)

| Level | Claim |
|-------|-------|
| 1 | Build process is documented/scripted |
| 2 | Builds run on a hosted, authenticated builder (CI) |
| 3 | Hardened build platform; provenance can't be forged |
| 4 | Two-party review + hermetic builds |

A GitLab/GitHub CI pipeline with signed provenance is roughly L2–L3.

## Labs for this lesson

| Lab | Path |
|-----|------|
| Distroless rebuild | [`src/07-supply-chain/distroless`](labs/distroless-images.md) |
| Trivy scan + gate | [`src/07-supply-chain/image-scanning`](labs/image-scanning.md) |
| SBOM + cosign | [`src/07-supply-chain/sbom-signing`](labs/sbom-and-signing.md) |

## Interview Questions

**Q: What's the difference between an SBOM and a vulnerability scan?**

A: SBOM is a *manifest* (what's inside); a scan is an *analysis* (which of
those things have known CVEs). Scanners consume SBOMs; you can scan without
a stored SBOM but you can't prove "what ran on Tuesday" without one.

**Q: Why distroless instead of just `alpine`?**

A: Alpine is small but still has a shell + apk — a full attack toolkit.
Distroless removes the shell entirely; nothing to `exec` into, nothing to
run a payload with.

**Q: How do you stop unsigned images reaching prod?**

A: Sign in CI (cosign keyless against the CI's OIDC identity), verify at
admission with Kyverno/Gatekeeper policy, and never expose mutable tags
(`latest`) to prod.

## Key Takeaways

✅ **Attack surface is a feature choice — distroless deletes it**
✅ **SBOM = provenance you can audit later**
✅ **Gate pipelines on HIGH/CRITICAL, fix by re-basing not whitelisting**
✅ **cosign keyless = signatures without key management**
✅ **Sign in CI → verify at admission = the full loop**
