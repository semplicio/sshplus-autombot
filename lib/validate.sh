#!/usr/bin/env bash
set -euo pipefail

validate_wsproxy() {
  [ -f /opt/sshplus-autombot/etc/ws.conf ] || { echo "ws.conf ausente"; exit 1; }
  [ -x /opt/sshplus-autombot/bin/wstunnel ] || { echo "wstunnel ausente"; exit 1; }
  [ -x /opt/sshplus-autombot/bin/start-wsproxy.sh ] || { echo "start-wsproxy.sh sem permissão"; exit 1; }

  bash -n /opt/sshplus-autombot/bin/start-wsproxy.sh
}