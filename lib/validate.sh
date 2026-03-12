#!/usr/bin/env bash
set -euo pipefail

validate_wsproxy() {
  [ -x "${BIN_DIR}/wstunnel" ] || { error "wstunnel não encontrado ou sem permissão"; exit 1; }
  [ -f "${ETC_DIR}/ws.conf" ] || { error "ws.conf não encontrado"; exit 1; }
  [ -x "${BIN_DIR}/start-wsproxy.sh" ] || { error "start-wsproxy.sh não encontrado ou sem permissão"; exit 1; }

  bash -n "${BIN_DIR}/start-wsproxy.sh" || {
    error "Erro de sintaxe em start-wsproxy.sh"
    exit 1
  }

  if systemctl list-unit-files | grep -q '^wsproxy.service'; then
    systemd-analyze verify /etc/systemd/system/wsproxy.service >/dev/null 2>&1 || {
      error "Arquivo wsproxy.service inválido"
      exit 1
    }
  fi

  log "Validação concluída com sucesso"
}