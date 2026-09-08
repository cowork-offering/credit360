#!/usr/bin/env bash
# sync-assets.sh — pull the delivered media into the page's own assets/ folder.
#
# The delivery folder is the source of truth and is never written to. This script
# only reads from it and writes web-shaped copies into site/assets/:
#
#   hero/     the 1.4 s aerial is slowed 2x and mirrored into a seamless ~5.7 s
#             loop, because a 1.4 s hard loop reads as a twitch behind the lockup
#   chapters/ the five muted loops, copied as delivered
#   film/     both resolutions, fragmented in place by tools/prepare-film.sh
#
# Usage: tools/sync-assets.sh [delivery-dir] [film-master.mp4]
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
src=${1:-$(cd "$here/../assets" && pwd)}
master=${2:-/opt/connectry/scratch/c360-film/assets/audio/vo/publish/finals/media/final3b-web.mp4}
a="$here/assets"
mkdir -p "$a/hero" "$a/chapters" "$a/film"

# ---- hero -------------------------------------------------------------------
# NOT the delivered hero/hero-aerial.mp4: that clip is the film's shot 1, which
# carries the Accenture ">" burned into the middle of the frame. Behind the page
# lockup that reads as two chevrons. This cuts the film's next shot instead, the
# Tower Bridge push (1.45 to 2.58 s), which is the same opening aerial move with
# no mark and no type on it. Slowed 2.2x and mirrored, it loops for ~5 s without
# a visible cut.
ffmpeg -v error -y -ss 1.45 -to 2.58 -i "$master" \
  -filter_complex "[0:v]setpts=2.2*PTS,split[a][b];[b]reverse[r];[a][r]concat=n=2:v=1:a=0,fps=24[v]" \
  -map "[v]" -c:v libx264 -preset slow -crf 23 -pix_fmt yuv420p -movflags +faststart -an \
  "$a/hero/hero-aerial.mp4"
ffmpeg -v error -y -ss 1.9 -i "$master" -frames:v 1 -vf scale=1600:-2 -q:v 5 "$a/hero/hero-aerial.jpg"

# ---- chapters: as delivered ----
for c in ch1-book ch2-relationship ch3-ask ch4-memo ch5-approve; do
  cp -f "$src/chapters/$c.mp4" "$a/chapters/$c.mp4"
  ffmpeg -v error -y -i "$src/chapters/$c-poster.jpg" -vf scale=1280:-2 -q:v 5 "$a/chapters/$c.jpg"
done

# ---- film ----
cp -f "$master" "$a/film/credit360-final3b.mp4"
cp -f "$src/film/credit360-final3b-720.mp4" "$a/film/credit360-final3b-720.mp4"
ffmpeg -v error -y -ss 1.9 -i "$master" -frames:v 1 -vf scale=1920:-2 -q:v 4 "$a/film/film-poster.jpg"
"$here/tools/prepare-film.sh" none >/dev/null

echo "--- assets/ ---"; du -sh "$a"/*; echo; ls -la "$a/hero" "$a/film"
