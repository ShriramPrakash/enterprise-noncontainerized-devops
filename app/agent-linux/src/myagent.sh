#!/bin/bash
set -euo pipefail

LOG_FILE="/var/log/myagent.log"
DATE_NOW=$(date '+%Y-%m-%d %H:%M:%S')

echo "$DATE_NOW - myagent heartbeat" >> "$LOG_FILE"
