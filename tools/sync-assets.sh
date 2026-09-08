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
#           Plus the gate plate: the CLOSE's San Francisco aerial turned tall
#           for the door's left pane, graded plum in the shadows and slowed
#           1.6x into an 11 s loop, so the page opens and closes on one city.
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

# THE GATE PLATE. San Francisco, turned tall: the door opens on the same city
# and the same light the page closes in, so the gate plate is cut from the
# CLOSE's own source (end/raw.mp4, the 5.04 s aerial drift) rather than from the
# London overture. 3.5 s of it, cropped 750x1072 at x 420 out of the 1928x1072
# frame and scaled to the pane's 672x960 portrait: that offset puts Salesforce
# Tower at 70% of the pane, standing its full height and clear of the centred
# mark, with the Bay Bridge and open water closing the bottom of the frame.
#
# The grade is the London plate's own curve, unchanged, and it is a BLACK POINT
# rather than a wash: +4/255 on red and +8/255 on blue with one step on green,
# so the shadows go cool plum while the golden hour in the mids and highs is
# left alone. That is what keeps the gate and the close reading as one light.
#
# Slowed 1.6x and mirrored into an 11 s ping-pong. 132 forward frames, so the
# reverse half is trimmed to frames 1..131: the turnaround drops the duplicated
# last frame and the restart drops the duplicated first, leaving both joins as
# single-frame steps. Measured over the finished loop, the turnaround is 2.10
# RMS and the restart 1.77 against a p95 of 2.42 for ordinary adjacent frames,
# so neither join is visible and the ping-pong is earned rather than assumed.
gplate=${4:-$src/end/raw.mp4}
t2=$(mktemp -d)
ffmpeg -v error -y -t 3.5 -i "$gplate" \
  -vf "crop=750:1072:420:0,scale=672:960:flags=lanczos,\
curves=r='0/0.016 0.5/0.5 1/1':g='0/0.004 0.5/0.5 1/1':b='0/0.030 0.5/0.506 1/1',\
eq=saturation=0.94:contrast=1.03,setpts=1.6*PTS,\
minterpolate=fps=24:mi_mode=mci:mc_mode=aobmc:vsbmc=1,format=yuv420p" \
  -an -c:v libx264 -preset slow -crf 18 "$t2/fwd.mp4"
ffmpeg -v error -y -i "$t2/fwd.mp4" -filter_complex \
  "[0:v]split[a][b];[b]reverse,trim=start_frame=1:end_frame=131,setpts=PTS-STARTPTS[r];[a][r]concat=n=2:v=1:a=0[o]" \
  -map "[o]" -an -c:v libx264 -preset slow -crf 24 -pix_fmt yuv420p -movflags +faststart \
  "$a/film/sf-gate-plate.mp4"
ffmpeg -v error -y -i "$a/film/sf-gate-plate.mp4" -frames:v 1 -q:v 6 "$a/film/sf-gate-plate.jpg"
rm -rf "$t2"
rm -rf "$t"

"$here/tools/prepare-film.sh" none >/dev/null

echo "--- assets/ ---"; du -sh "$a"/*
