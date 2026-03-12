#!/usr/bin/env bash
set -euo pipefail

install_wstunnel() {
  local arch url

  arch="$(uname -m)"

  case "$arch" in
    x86_64|amd64)
      url="https://github.com/erebe/wstunnel/releases/latest/download/wstunnel_linux_amd64"
      ;;
    aarch64|arm64)
      url="https://github.com/erebe/wstunnel/releases/latest/download/wstunnel_linux_arm64"
      ;;
    *)
      echo "Arquitetura não suportada: $arch"
      exit 1
      ;;
  esac

  mkdir -p /opt/sshplus-autombot/bin
  curl -L "$url" -o /opt/sshplus-autombot/bin/wstunnel
  chmod +x /opt/sshplus-autombot/bin/wstunnel

  /opt/sshplus-autombot/bin/wstunnel --help >/dev/null
}