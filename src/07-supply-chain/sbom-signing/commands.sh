#!/usr/bin/env bash
# Lab: produce an SBOM, then sign + verify an image with cosign.
# Fill the TODOs; compare with solution/commands.sh

set -euo pipefail
IMAGE=distroless-app

# TODO 1: generate a CycloneDX SBOM of the image with syft
# syft $IMAGE -o ... > sbom.json

# TODO 2: inspect it — how many packages? (jq length on .components)

# TODO 3: sign the image digest (cosign sign — keyless prompts for OIDC
# browser login; needs a pushed image, so retag to your registry first)

# TODO 4: verify the signature
# cosign verify $IMAGE --certificate-identity=... --certificate-oidc-issuer=...
