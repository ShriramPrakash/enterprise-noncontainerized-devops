Name:           myagent
Version:        1.0.0
Release:        1%{?dist}
Summary:        Sample Linux Agent
License:        Internal
BuildArch:      noarch

Source0:        myagent.sh
Source1:        myagent.service
Source2:        config.env

%description
Sample Linux agent service.

%prep

%build

%install
mkdir -p %{buildroot}/usr/local/bin
mkdir -p %{buildroot}/etc/myagent
mkdir -p %{buildroot}/etc/systemd/system

install -m 0755 %{SOURCE0} %{buildroot}/usr/local/bin/myagent.sh
cat > %{buildroot}/usr/local/bin/myagent-loop.sh <<'EOF'
#!/bin/bash
while true; do
  /usr/local/bin/myagent.sh
  sleep 60
done
EOF
chmod 0755 %{buildroot}/usr/local/bin/myagent-loop.sh

install -m 0644 %{SOURCE1} %{buildroot}/etc/systemd/system/myagent.service
install -m 0644 %{SOURCE2} %{buildroot}/etc/myagent/config.env

%post
systemctl daemon-reload || true
systemctl enable myagent || true
systemctl restart myagent || true

%preun
systemctl stop myagent || true
systemctl disable myagent || true

%files
/usr/local/bin/myagent.sh
/usr/local/bin/myagent-loop.sh
/etc/myagent/config.env
/etc/systemd/system/myagent.service
