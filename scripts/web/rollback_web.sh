#!/bin/bash
set -euo pipefail

APP_BASE="/opt/company/web"
RELEASES="$APP_BASE/releases"
CURRENT="$APP_BASE/current"

PREVIOUS_VERSION=$(ls -1 "$RELEASES" | sort -V | tail -n 2 | head -n 1)

if [ -z "${PREVIOUS_VERSION:-}" ]; then
  echo "No previous release found"
  exit 1
fi

sudo ln -sfn "$RELEASES/$PREVIOUS_VERSION/app/web" "$CURRENT"
sudo systemctl restart company-web
