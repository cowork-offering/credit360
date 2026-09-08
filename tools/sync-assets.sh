#!/usr/bin/env bash
# sync-assets.sh — pull the delivered media into the page's own assets/ folder.
#
# The delivery folder is the source of truth and is never written to. This script
# only reads from it and writes web-shaped copies into site/assets/:
#
#   hero/     the 1.4 s raw aerial plate is interpolated, slowed 3x and mirrored
#             into a seamless 8.5 s loop, because a 1.4 s hard loop reads as a
#             twitch behind the lockup
#   chapters/ the five muted loops, copied as delivered
#   film/     both resolutions, fragmented in place by tools/prepare-film.sh
#
# Usage: tools/sync-assets.sh [delivery-dir] [film-master.mp4] [hero-plate.mp4]
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
src=${1:-$(cd "$here/../assets" && pwd)}
master=${2:-/opt/connectry/scratch/c360-film/assets/audio/vo/publish/finals/media/final3b-web.mp4}
a="$here/assets"
mkdir -p "$a/hero" "$a/chapters" "$a/film"

# ---- hero -------------------------------------------------------------------
# The clean raw aerial plate the film's shot 1 was cut from: London pre-dawn from
# altitude, Canary Wharf and the Thames, a slow push. No chevron, no type, and
# none of the radial motion blur the Tower Bridge warp-zoom carries, which read
# as a smear in a still.
#
# The plate is only 34 frames (1.417 s), so it is interpolated to 72 fps and
# stretched 3x into 4.25 s, then mirrored into an 8.5 s ping-pong. The join sits
# on the plate's own first and last frames and never cuts, so the loop reads as
# one continuous drift. Frame doubling judders at 3x; mci is clean on this
# footage (checked at 1:1 on a synthesised frame).
plate=${3:-/opt/connectry/scratch/c360-film/overture/assets/video/V1-aerial-push-film-1080p-cut.mp4}
ffmpeg -v error -y -i "$plate" -filter_complex \
  "[0:v]minterpolate=fps=72:mi_mode=mci:mc_mode=aobmc:me_mode=bidir:vsbmc=1,setpts=3.0*PTS,fps=24,split[a][b];[b]reverse[r];[a][r]concat=n=2:v=1:a=0[v]" \
  -map "[v]" -c:v libx264 -preset slow -crf 22 -pix_fmt yuv420p -movflags +faststart -an \
  "$a/hero/hero-aerial.mp4"
# poster from the plate's sharpest frame (laplacian variance over all 34)
ffmpeg -v error -y -i "$plate" -vf "select='eq(n\,30)',scale=1600:-2" -fps_mode passthrough \
  -frames:v 1 -q:v 5 "$a/hero/hero-aerial.jpg"

# ---- chapters: as delivered ----
for c in ch1-book ch2-relationship ch3-ask ch4-memo ch5-approve; do
  cp -f "$src/chapters/$c.mp4" "$a/chapters/$c.mp4"
  ffmpeg -v error -y -i "$src/chapters/$c-poster.jpg" -vf scale=1280:-2 -q:v 5 "$a/chapters/$c.jpg"
done

# ---- film ----
cp -f "$master" "$a/film/credit360-final3b.mp4"
cp -f "$src/film/credit360-final3b-720.mp4" "$a/film/credit360-final3b-720.mp4"
# The poster has to be the film's own opening aerial, not a later shot: it is what
# fills the player while the hero cross-fades out, and a Tower Bridge still there
# (1.9 s) flashed a different shot into the middle of the handover. 1.25 s is the
# first frame at full brightness with the chevron landed.
ffmpeg -v error -y -ss 1.25 -i "$master" -frames:v 1 -vf scale=1920:-2 -q:v 4 "$a/film/film-poster.jpg"
"$here/tools/prepare-film.sh" none >/dev/null

echo "--- assets/ ---"; du -sh "$a"/*; echo; ls -la "$a/hero" "$a/film"
