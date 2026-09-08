#!/usr/bin/env bash
# sync-assets.sh — pull the delivered media into the page's own assets/ folder.
#
# The delivery folder is the source of truth and is never written to. This script
# only reads from it and writes web-shaped copies into site/assets/.
#
# The page carries ONE piece of media: the reel. Everything else on it is the
# product's own UI, built as live HTML, so there is nothing else to sync.
#
#   film/   both resolutions, fragmented in place by tools/prepare-film.sh,
#           plus the hero plate: the CLEAN raw aerial the film's shot 1 was cut
#           from (34 f, 1.417 s), interpolated to 72 fps, stretched 3x and
#           mirrored into an 8.417 s ping-pong. The join sits on the plate's own
#           first and last frames and never cuts. The page overlays its own
#           chevron on it at the film's 70%, so the reel's first frame, which
#           carries the same mark at the same place, cross-fades without a cut.
#
# Usage: tools/sync-assets.sh [delivery-dir] [film-master.mp4]
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
src=${1:-$(cd "$here/../assets" && pwd)}
master=${2:-/opt/connectry/scratch/c360-film/assets/audio/vo/publish/finals/media/final3b-web.mp4}
a="$here/assets"
mkdir -p "$a/film"

plate=${3:-/opt/connectry/scratch/c360-film/overture/assets/video/V1-aerial-push-film-1080p-cut.mp4}

cp -f "$master" "$a/film/credit360-final3b.mp4"
cp -f "$src/film/credit360-final3b-720.mp4" "$a/film/credit360-final3b-720.mp4"

t=$(mktemp -d)
ffmpeg -v error -y -i "$plate" \
  -vf "minterpolate=fps=72:mi_mode=mci:mc_mode=aobmc:vsbmc=1,setpts=3.0*PTS,scale=1600:-2,fps=24" \
  -an -c:v libx264 -preset slow -crf 24 -pix_fmt yuv420p "$t/fwd.mp4"
ffmpeg -v error -y -i "$t/fwd.mp4" -filter_complex \
  "[0:v]split[a][b];[b]reverse,trim=start_frame=1:end_frame=101,setpts=PTS-STARTPTS[r];[a][r]concat=n=2:v=1:a=0[o]" \
  -map "[o]" -an -c:v libx264 -preset slow -crf 24 -pix_fmt yuv420p -movflags +faststart \
  "$a/film/hero-plate.mp4"
ffmpeg -v error -y -i "$a/film/hero-plate.mp4" -frames:v 1 -q:v 4 "$a/film/hero-plate.jpg"
rm -rf "$t"

"$here/tools/prepare-film.sh" none >/dev/null

echo "--- assets/ ---"; du -sh "$a"/*
