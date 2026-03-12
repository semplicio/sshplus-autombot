#!/usr/bin/env bash
set -euo pipefail

source /opt/sshplus-autombot/etc/ws.conf

WSTUNNEL_BIN="/opt/sshplus-autombot/bin/wstunnel"

if [ ! -x "$WSTUNNEL_BIN" ]; then
  echo "Binário wstunnel não encontrado: $WSTUNNEL_BIN"
  exit 127
fi

exec "$WSTUNNEL_BIN" -s "${WS_BIND}:${WS_PORT}" -t "${WS_TARGET}"