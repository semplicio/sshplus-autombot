#!/usr/bin/env bash
set -euo pipefail

install_wstunnel() {
  local arch url target
  arch="$(detect_arch)"
  target="${BIN_DIR}/wstunnel"

  case "$arch" in
    amd64)
      url="https://github.com/erebe/wstunnel/releases/latest/download/wstunnel_linux_amd64"
      ;;
    arm64)
      url="https://github.com/erebe/wstunnel/releases/latest/download/wstunnel_linux_arm64"
      ;;
    *)
      error "Arquitetura inválida: $arch"
      exit 1
      ;;
  esac

  log "Instalando wstunnel para arquitetura: $arch"
  curl -fsSL "$url" -o "$target"
  chmod +x "$target"

  if ! "$target" --help >/dev/null 2>&1; then
    error "Falha ao validar binário do wstunnel"
    exit 1
  fi

  log "wstunnel instalado em: $target"
}