#!/usr/bin/env bash
# prepare-film.sh — turn the delivered reel into what the page streams.
#
#   1. copies the graded masters into assets/film/ (1080p + 720p)
#   2. writes fragmented (fMP4) copies with -c copy, so no re-encode and no
#      quality loss. The page feeds these to MediaSource, which is what lets
#      playback start on the first few seconds instead of the whole 55 MB.
#   3. cuts a poster at 1.25 s if one is not supplied: the player wears it while
#      the hero cross-fades out, so it has to be the film's own opening aerial
#   4. writes assets/film/film.json with the exact codec string MSE needs
#
# Usage:  tools/prepare-film.sh [source-dir]
#         source-dir defaults to ../assets/film
set -euo pipefail
here=$(cd "$(dirname "$0")/.." && pwd)
src=${1:-$(cd "$here/../assets/film" 2>/dev/null && pwd || echo "")}
out="$here/assets/film"
mkdir -p "$out"

if [[ -n "$src" && "$src" != "none" && -f "$src/credit360-final3b.mp4" ]]; then
  cp -f "$src/credit360-final3b.mp4" "$out/"
  [[ -f "$src/credit360-final3b-720.mp4" ]] && cp -f "$src/credit360-final3b-720.mp4" "$out/"
  for p in film-poster.jpg credit360-final3b.jpg poster.jpg; do
    [[ -f "$src/$p" ]] && cp -f "$src/$p" "$out/film-poster.jpg" && break
  done
fi

[[ -f "$out/credit360-final3b.mp4" ]] || { echo "no reel at $out/credit360-final3b.mp4" >&2; exit 1; }
[[ -f "$out/credit360-final3b-720.mp4" ]] || \
  ffmpeg -v error -y -i "$out/credit360-final3b.mp4" -vf scale=1280:-2 -c:v libx264 -preset slow -crf 23 \
    -c:a aac -b:a 128k -movflags +faststart "$out/credit360-final3b-720.mp4"
[[ -f "$out/film-poster.jpg" ]] || \
  ffmpeg -v error -y -ss 1.25 -i "$out/credit360-final3b.mp4" -frames:v 1 -q:v 2 "$out/film-poster.jpg"

# Fragment in place. A fragmented MP4 still plays as an ordinary file, so one
# artefact serves both the MediaSource path and the blob fallback, and the repo
# carries one copy of each resolution instead of two.
frag() {
  ffmpeg -v error -y -i "$1" -c copy \
    -movflags +frag_keyframe+empty_moov+default_base_moof "${1%.mp4}.tmp.mp4" && mv -f "${1%.mp4}.tmp.mp4" "$1"
}
frag "$out/credit360-final3b.mp4"
frag "$out/credit360-final3b-720.mp4"

python3 - "$out" <<'PY'
import json, subprocess, sys, os
out = sys.argv[1]
src = os.path.join(out, "credit360-final3b.mp4")
j = json.loads(subprocess.check_output([
    "ffprobe","-v","quiet","-print_format","json","-show_format","-show_streams",src]))
vid = next((s for s in j["streams"] if s["codec_type"]=="video"), None)
aud = next((s for s in j["streams"] if s["codec_type"]=="audio"), None)
PROF = {"Baseline":0x42,"Constrained Baseline":0x42,"Main":0x4D,"High":0x64,
        "High 10":0x6E,"High 4:2:2":0x7A,"High 4:4:4 Predictive":0xF4}
p = PROF.get(vid.get("profile",""), 0x64)
lvl = int(float(vid.get("level", 40)))
codecs = "avc1.%02X00%02X" % (p, lvl)
if aud:
    codecs += ",mp4a.40.2"
m = {
  "src":  "assets/film/credit360-final3b.mp4",
  "src720": "assets/film/credit360-final3b-720.mp4",
  "frag": "assets/film/credit360-final3b.mp4",
  "frag720": "assets/film/credit360-final3b-720.mp4",
  "mime": 'video/mp4; codecs="%s"' % codecs.lower(),
  "duration": round(float(j["format"]["duration"]), 3),
  "width": vid.get("width"), "height": vid.get("height")
}
open(os.path.join(out, "film.json"), "w").write(json.dumps(m, indent=2) + "\n")
print(json.dumps(m, indent=2))
PY
