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
THEME_DIR="${RHAVENS_DREAM_THEME_DIR:-$HOME/.config/rhavens_dream/themes}"

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

# Fetch release metadata once (no auth needed for public repo)
RELEASE_JSON=$(curl -sS "$RELEASE_URL")

# Resolve download URL for the binary
DOWNLOAD_URL=$(printf '%s\n' "$RELEASE_JSON" | grep -o "\"browser_download_url\": *\"[^\"]*${ASSET_NAME}\"" | head -1 | sed 's/.*: *"\(.*\)".*/\1/')

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
  echo "Or add the line above to your ~/.zshrc oder ~/.bashrc"
fi

# Download bundled themes (if available in the release)
mkdir -p "$THEME_DIR"
THEME_URLS=$(printf '%s\n' "$RELEASE_JSON" | grep -o "\"browser_download_url\": *\"[^\"]*\\.omp.json\"" | sed 's/.*: *\"\(.*\)\".*/\1/')

if [ -n "$THEME_URLS" ]; then
  echo "Installing themes into $THEME_DIR"
  DEFAULT_THEME_PATH=""
  first=1
  echo "$THEME_URLS" | while IFS= read -r url; do
    [ -z "$url" ] && continue
    name=$(basename "$url")
    echo "  - $name"
    curl -sSL -o "$THEME_DIR/$name" "$url" || echo "    (Warnung: Konnte $name nicht herunterladen)"
    if [ $first -eq 1 ]; then
      DEFAULT_THEME_PATH="$THEME_DIR/$name"
      first=0
    fi
  done

  THEME_PATH_FILE="$HOME/.config/rhavens_dream/theme_path"
  if [ -n "$DEFAULT_THEME_PATH" ] && [ ! -f "$THEME_PATH_FILE" ]; then
    mkdir -p "$(dirname "$THEME_PATH_FILE")"
    printf '%s\n' "$DEFAULT_THEME_PATH" > "$THEME_PATH_FILE"
    echo "Default-Theme gesetzt auf: $DEFAULT_THEME_PATH"
  fi
else
  echo "Hinweis: Keine Theme-Dateien (.omp.json) im Release gefunden."
fi
