#!/bin/bash
set -euo pipefail

PREVIOUS_RPM="$1"
sudo rpm -Uvh --oldpackage "$PREVIOUS_RPM"
sudo systemctl restart myagent
