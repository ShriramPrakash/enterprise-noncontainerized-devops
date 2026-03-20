#!/bin/bash
set -euo pipefail

ARTIFACT_ZIP="$1"
VERSION="$2"

APP_BASE="/opt/company/web"
RELEASES="$APP_BASE/releases"
CURRENT="$APP_BASE/current"

sudo mkdir -p "$RELEASES/$VERSION"
sudo unzip -o "$ARTIFACT_ZIP" -d "$RELEASES/$VERSION"

cd "$RELEASES/$VERSION/app/web"
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt
deactivate

sudo ln -sfn "$RELEASES/$VERSION/app/web" "$CURRENT"

cat <<'EOF' | sudo tee /etc/systemd/system/company-web.service >/dev/null
[Unit]
Description=Company Web App
After=network.target

[Service]
User=ec2-user
WorkingDirectory=/opt/company/web/current
ExecStart=/opt/company/web/current/venv/bin/gunicorn -w 2 -b 0.0.0.0:5000 src.app:app
Restart=always

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable company-web
sudo systemctl restart company-web
sudo systemctl status company-web --no-pager
