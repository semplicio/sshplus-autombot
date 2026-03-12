#!/usr/bin/env bash
set -euo pipefail

healthcheck_wsproxy() {
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "         STATUS WEBSOCKET SSH"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo

  if [ -f "${ETC_DIR}/ws.conf" ]; then
    # shellcheck disable=SC1090
    source "${ETC_DIR}/ws.conf"
    echo "WS_PORT=${WS_PORT:-}"
    echo "WS_BIND=${WS_BIND:-}"
    echo "WS_TARGET=${WS_TARGET:-}"
  else
    echo "Arquivo ws.conf não encontrado"
  fi

  echo
  systemctl status wsproxy.service --no-pager -l || true
  echo
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "PORTA"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  ss -lntp | grep ":${WS_PORT:-8080}" || true

  echo
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  echo "LOGS"
  echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  journalctl -u wsproxy.service -n 20 --no-pager || true
}