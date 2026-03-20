#!/bin/bash
set -euo pipefail

curl -f http://localhost:5000/health
echo "Smoke test passed"
