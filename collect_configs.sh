#!/usr/bin/env bash
set -euo pipefail

# Base directory inside your repo
REPO_DIR="$(pwd)/dotfiles"

# List of paths to collect
PATHS=(
  "/home/kavish/.config/fish/config.fish"
  "/home/kavish/.config/hypr"
  "/home/kavish/.config/swaync"
  "/home/kavish/.config/waybar"
  "/home/kavish/.config/mpv"
  "/home/kavish/scripts"
)

echo "Collecting config files into $REPO_DIR"
mkdir -p "$REPO_DIR"

for SRC in "${PATHS[@]}"; do
  if [[ -e "$SRC" ]]; then
    DEST="$REPO_DIR$SRC"
    echo "→ Copying $SRC"
    mkdir -p "$(dirname "$DEST")"
    rsync -a --delete "$SRC" "$DEST"
  else
    echo "⚠ Skipping $SRC (not found)"
  fi
done

echo "Done. Configs collected successfully."
