#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load env vars from .env, fall back to current env
if [ -f "$SCRIPT_DIR/.env" ]; then
  set -a
  source "$SCRIPT_DIR/.env"
  set +a
fi

ARGS=${@-omnigent host --server http://omnigent:8000}
docker run -it --rm \
  --network omnigent_default \
  -v "$SCRIPT_DIR/agents:/agents" \
  -e GROQ_API_KEY="${GROQ_API_KEY}" \
  ghcr.io/omnigent-ai/omnigent-host:latest \
  $ARGS
