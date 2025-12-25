#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(pwd)/dotfiles"

PATHS=(
  "/home/kavish/.config/fish/config.fish"
  "/home/kavish/.config/hypr"
  "/home/kavish/.config/swaync"
  "/home/kavish/.config/waybar"
  "/home/kavish/.config/mpv"
  "/home/kavish/scripts"
)

echo "Applying config files from $REPO_DIR"

for DEST in "${PATHS[@]}"; do
  SRC="$REPO_DIR$DEST"
  if [[ -e "$SRC" ]]; then
    echo "→ Restoring $DEST"
    mkdir -p "$(dirname "$DEST")"
    rsync -a "$SRC" "$DEST"
  else
    echo "⚠ Skipping $SRC (not found in repo)"
  fi
done

echo "Done. Configs restored successfully."
