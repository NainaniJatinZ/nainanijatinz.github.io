#!/usr/bin/env bash

set -euo pipefail

DRAW_DIR="${1:-assets/draw}"
MAX_SIZE="${MAX_SIZE:-2200}"

if ! command -v qlmanage >/dev/null 2>&1; then
  echo "qlmanage is required but not found." >&2
  exit 1
fi

if [[ ! -d "$DRAW_DIR" ]]; then
  echo "Directory not found: $DRAW_DIR" >&2
  exit 1
fi

tmpdir="$(mktemp -d "${TMPDIR:-/tmp}/heic-convert.XXXXXX")"
trap 'rm -rf "$tmpdir"' EXIT

converted=0
skipped=0
normalized=0

while IFS= read -r -d '' src; do
  dir="$(dirname "$src")"
  filename="$(basename "$src")"
  stem="${filename%.*}"
  target="$dir/$stem.png"
  legacy_target="$dir/$filename.png"
  tmp_output="$tmpdir/$filename.png"

  if [[ -f "$target" ]]; then
    echo "skip  $target"
    skipped=$((skipped + 1))
    continue
  fi

  if [[ -f "$legacy_target" ]]; then
    mv "$legacy_target" "$target"
    echo "fix   $target"
    normalized=$((normalized + 1))
    continue
  fi

  rm -f "$tmp_output"
  qlmanage -t -s "$MAX_SIZE" -o "$tmpdir" "$src" >/dev/null

  if [[ ! -f "$tmp_output" ]]; then
    echo "failed to convert: $src" >&2
    exit 1
  fi

  mv "$tmp_output" "$target"
  echo "made  $target"
  converted=$((converted + 1))
done < <(find "$DRAW_DIR" -type f \( -iname '*.heic' \) -print0 | sort -z)

echo
echo "Converted: $converted"
echo "Normalized legacy names: $normalized"
echo "Skipped existing PNGs: $skipped"
