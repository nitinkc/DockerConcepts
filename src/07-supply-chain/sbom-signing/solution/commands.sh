#!/usr/bin/env bash
set -euo pipefail

# 1. SBOM — the ingredient list (CycloneDX is the common format; SPDX alt)
syft distroless-app -o cyclonedx-json > sbom.json

# 2. What's inside? Distroless ≈ 1–3 packages vs ~100+ for debian-based
jq '.components | length' sbom.json
jq -r '.components[] | "\(.name)@\(.version)"' sbom.json

# 3. Sign — requires the image to exist in a registry (digest-addressable)
docker tag distroless-app <your-registry>/distroless-app:1.0.0
docker push <your-registry>/distroless-app:1.0.0

cosign sign <your-registry>/distroless-app:1.0.0
#   keyless: opens OIDC login (GitHub/Google), Fulcio issues a short-lived
#   cert binding the signature to YOUR identity — no keys to manage

# 4. Verify — this is what an admission controller does in-cluster
cosign verify <your-registry>/distroless-app:1.0.0 \
  --certificate-identity=<your-oidc-identity> \
  --certificate-oidc-issuer=https://accounts.google.com
