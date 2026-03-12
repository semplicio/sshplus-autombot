#!/usr/bin/env bash
set -euo pipefail

PROJECT_ROOT="/opt/sshplus-autombot"
BIN_DIR="${PROJECT_ROOT}/bin"
ETC_DIR="${PROJECT_ROOT}/etc"
LOG_DIR="${PROJECT_ROOT}/log"

log() {
  echo -e "[INFO] $*"
}

warn() {
  echo -e "[WARN] $*"
}

error() {
  echo -e "[ERRO] $*" >&2
}

ensure_dirs() {
  mkdir -p "$BIN_DIR" "$ETC_DIR" "$LOG_DIR"
}

detect_arch() {
  local arch
  arch="$(uname -m)"

  case "$arch" in
    x86_64|amd64)
      echo "amd64"
      ;;
    aarch64|arm64)
      echo "arm64"
      ;;
    *)
      error "Arquitetura não suportada: $arch"
      exit 1
      ;;
  esac
}