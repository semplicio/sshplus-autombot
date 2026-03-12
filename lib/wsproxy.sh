#!/usr/bin/env bash
set -euo pipefail

install_wsproxy_module() {
  ensure_dirs

  log "Criando ws.conf"
  cat > "${ETC_DIR}/ws.conf" <<EOF
WS_PORT=${WS_PORT:-8080}
WS_BIND=${WS_BIND:-0.0.0.0}
WS_TARGET=${WS_TARGET:-127.0.0.1:22}
EOF

  log "Criando start-wsproxy.sh"
  cat > "${BIN_DIR}/start-wsproxy.sh" <<'EOF'
#!/usr/bin/env bash
set -euo pipefail

source /opt/sshplus-autombot/etc/ws.conf

WSTUNNEL_BIN="/opt/sshplus-autombot/bin/wstunnel"

if [ ! -x "$WSTUNNEL_BIN" ]; then
  echo "Binário wstunnel não encontrado: $WSTUNNEL_BIN"
  exit 127
fi

exec "$WSTUNNEL_BIN" -s "${WS_BIND}:${WS_PORT}" -t "${WS_TARGET}"
EOF

  chmod +x "${BIN_DIR}/start-wsproxy.sh"
  sed -i 's/\r$//' "${BIN_DIR}/start-wsproxy.sh"

  log "Instalando wstunnel"
  install_wstunnel

  log "Criando service systemd"
  cp "${SCRIPT_DIR}/templates/wsproxy.service.tpl" /etc/systemd/system/wsproxy.service

  log "Validando instalação"
  validate_wsproxy

  log "Recarregando systemd"
  systemctl daemon-reload
  systemctl enable wsproxy.service
  systemctl restart wsproxy.service

  log "Executando healthcheck"
  healthcheck_wsproxy
}