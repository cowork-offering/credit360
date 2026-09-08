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
#           plus the poster cut from the film's own opening aerial at 1.25 s
#           (the first frame at full brightness with the chevron landed)
#
# Usage: tools/sync-assets.sh [delivery-dir] [film-master.mp4]
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
src=${1:-$(cd "$here/../assets" && pwd)}
master=${2:-/opt/connectry/scratch/c360-film/assets/audio/vo/publish/finals/media/final3b-web.mp4}
a="$here/assets"
mkdir -p "$a/film"

cp -f "$master" "$a/film/credit360-final3b.mp4"
cp -f "$src/film/credit360-final3b-720.mp4" "$a/film/credit360-final3b-720.mp4"
ffmpeg -v error -y -ss 1.25 -i "$master" -frames:v 1 -vf scale=1920:-2 -q:v 4 "$a/film/film-poster.jpg"
"$here/tools/prepare-film.sh" none >/dev/null

echo "--- assets/ ---"; du -sh "$a"/*
