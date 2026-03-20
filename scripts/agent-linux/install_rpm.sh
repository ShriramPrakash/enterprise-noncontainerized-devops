#!/bin/bash
set -euo pipefail

RPM_FILE="$1"
sudo rpm -Uvh --force "$RPM_FILE"
sudo systemctl daemon-reload
sudo systemctl enable myagent
sudo systemctl restart myagent
sudo systemctl status myagent --no-pager
