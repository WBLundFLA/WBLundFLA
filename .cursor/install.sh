#!/usr/bin/env bash
# Idempotent setup for the profile README development environment.
# Installs grip (GitHub Readme Instant Preview) into an isolated venv so the
# README can be previewed exactly as GitHub renders it.
set -euo pipefail

VENV="$HOME/.venv-tools"

# Debian/Ubuntu ships venv/ensurepip in a separate package; install it if the
# stdlib venv bootstrap is unavailable.
if ! python3 -c "import ensurepip" >/dev/null 2>&1; then
  sudo apt-get update -qq
  sudo apt-get install -y -qq python3-venv
fi

# Create the tools venv once; reuse it on subsequent runs.
if [ ! -x "$VENV/bin/python" ]; then
  python3 -m venv "$VENV"
fi

"$VENV/bin/pip" install --quiet --upgrade pip grip

echo "grip installed: $("$VENV/bin/grip" --version)"
