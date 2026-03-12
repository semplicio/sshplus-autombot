#!/usr/bin/env bash
set -euo pipefail

echo "=== WSProxy ==="
systemctl is-active wsproxy.service || true
systemctl is-enabled wsproxy.service || true

echo
echo "=== Porta ==="
ss -lntp | grep ':8080' || true

echo
echo "=== Binário ==="
ls -l /opt/sshplus-autombot/bin/wstunnel || true

echo
echo "=== Logs ==="
journalctl -u wsproxy.service -n 20 --no-pager || true