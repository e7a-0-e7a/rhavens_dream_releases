#!/usr/bin/env bash
# Install script for rhavens_dream – downloads latest release from GitHub.
# Usage: curl -sSL https://raw.githubusercontent.com/e7a-0-e7a/rhavens_dream_releases/main/install.sh | bash
#
# Replace e7a-0-e7a with your GitHub username/org before publishing this repo.

set -e

REPO="${RHAVENS_DREAM_REPO:-e7a-0-e7a/rhavens_dream_releases}"
BIN_NAME="rhavens_dream"
INSTALL_DIR="${RHAVENS_DREAM_INSTALL_DIR:-$HOME/.local/bin}"
RELEASE_URL="https://api.github.com/repos/${REPO}/releases/latest"

# Detect OS and arch for asset name
OS=$(uname -s)
ARCH=$(uname -m)

case "$OS" in
  Darwin)  PLATFORM="apple-darwin" ;;
  Linux)   PLATFORM="unknown-linux-gnu" ;;
  MINGW*|MSYS*) PLATFORM="pc-windows-msvc" ;;
  *)       echo "Unsupported OS: $OS"; exit 1 ;;
esac

case "$ARCH" in
  x86_64|amd64)  TARGET_ARCH="x86_64" ;;
  aarch64|arm64) TARGET_ARCH="aarch64" ;;
  *)             echo "Unsupported arch: $ARCH"; exit 1 ;;
esac

if [ "$PLATFORM" = "pc-windows-msvc" ]; then
  ASSET_NAME="${BIN_NAME}-${TARGET_ARCH}-${PLATFORM}.exe"
else
  ASSET_NAME="${BIN_NAME}-${TARGET_ARCH}-${PLATFORM}"
fi

echo "Installing rhavens_dream from $REPO (asset: $ASSET_NAME) into $INSTALL_DIR"

mkdir -p "$INSTALL_DIR"

# Resolve download URL from GitHub API (no auth needed for public repo)
DOWNLOAD_URL=$(curl -sS "$RELEASE_URL" | grep -o "\"browser_download_url\": *\"[^\"]*${ASSET_NAME}\"" | head -1 | sed 's/.*: *"\(.*\)".*/\1/')

if [ -z "$DOWNLOAD_URL" ]; then
  echo "No release asset found for: $ASSET_NAME"
  echo "Check: https://github.com/${REPO}/releases"
  exit 1
fi

echo "Downloading: $DOWNLOAD_URL"
curl -sSL -o "$INSTALL_DIR/$BIN_NAME" "$DOWNLOAD_URL"
chmod +x "$INSTALL_DIR/$BIN_NAME"

echo "Installed: $INSTALL_DIR/$BIN_NAME"
if ! command -v "$BIN_NAME" >/dev/null 2>&1; then
  echo "Add to PATH: export PATH=\"$INSTALL_DIR:\$PATH\""
  echo "Or add the line above to your ~/.zshrc or ~/.bashrc"
fi
