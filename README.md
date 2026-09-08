# > Credit 360

The launch page for the Credit 360 film. Dreamforce 2026. Accenture.

One page. A gate, a hero, the film, five pinned chapters, an endcard. No nav bar,
no feature list, no logo wall. The page is the film's title sequence extended
into a site.

```
index.html            the whole page: markup, tokens, styles, choreography
assets/
  gate.js             the invitation gate (loaded synchronously in <head>)
  fonts/              Graphik woff2, self-hosted, same faces as the roadshow site
  logos/              Accenture wordmark
  vendor/             GSAP 3.12.5 + ScrollTrigger, Lenis 1.1.20, pinned and vendored
  hero/               the aerial loop behind the hero, and its poster
  film/               the reel (1080p and 720p) + film.json + the poster
  chapters/           the five muted cockpit loops and their posters
tools/
  sync-assets.sh      pull the delivered media into assets/ in web shape
  prepare-film.sh     fragment the reel and write film.json
```

## The gate

The passcode is **dreamforce2026**, verified in the browser.

`assets/gate.js` holds the salted SHA-256 of the phrase and nothing else:

```
SALT = 'c360-premiere:'
HASH = sha256(SALT + phrase.trim().toLowerCase())
     = e324137a08515de0a585f28b33865b7d02e7ccf129d1b0e1675653162e40b508
```

On submit the page hashes `SALT + input` with WebCrypto (with a small pure-JS
SHA-256 fallback for `file://` previews) and compares. The plaintext phrase is
never in the repo. A correct unlock writes `{h, t}` to `localStorage` under
`c360.gate.v1` and is remembered on that device for 30 days.

The gate is a separate overlay that is mounted before anything else and hides the
page from first paint (`html.gate-locked`), so there is no flash of the site
behind it and **the film's URL is never in the DOM before entry**: the `<video>`
carries no `src` and `film.json` is not fetched until the gate opens.

Wrong phrase: the chevron dims and the field shakes two pixels, once.
Right phrase: the chevron strikes to full purple, then the black lifts over 600 ms.

To re-lock a machine (booth reset): append `?lock` to the URL, or run
`c360Gate.lock()` in the console.

**This is a courtesy lock, not a security boundary.** GitHub Pages serves static
files: anyone who opens devtools can read `gate.js`, and a determined visitor can
brute-force a known-format phrase offline. It keeps the page off the open web for
a casual visitor. It does not protect the film from someone who wants it.

To change the phrase:

```bash
python3 -c "import hashlib; print(hashlib.sha256(('c360-premiere:'+'NEWPHRASE').encode()).hexdigest())"
# paste the result into HASH in assets/gate.js, and bump KEY to c360.gate.v2
```

## The film, and why it is not downloadable

The reel is streamed into the page through MediaSource after unlock and attached
as a `blob:` URL, so no plain file URL sits in the markup. The player also sets
`controlslist="nodownload noremoteplayback noplaybackrate"`,
`disablepictureinpicture`, `disableremoteplayback`, uses no native controls, and
suppresses the context menu over the player.

**A determined engineer can still capture the film.** The bytes reach the browser,
so they can be read from the network panel, from the fragmented MP4 that
`film.json` names, or by recording the screen. These measures stop a right-click
and a casual save. They are not DRM and should not be described as such.

`tools/prepare-film.sh` writes the film as a fragmented MP4 (`-movflags
+frag_keyframe+empty_moov+default_base_moof`, stream copy, no re-encode). That is
what lets MediaSource start playback on the first fragments instead of waiting for
all 55 MB, and a fragmented MP4 still plays as an ordinary file, so one artefact
per resolution serves both the MediaSource path and the blob fallback.

The page warms the fetch as soon as the hero is up, picks the 720p file under
900 px of viewport, and falls back to a whole-file blob if MediaSource is
unavailable.

## Themes, motion, type

Dark is the primary theme and the page follows the operating system; append
`?theme=light` or `?theme=dark` to force one. The three media surfaces (gate,
hero, film, endcard) stay cinematic black in both themes because they carry the
film; the chapter band between them is the one that turns editorial white.

Every value is a design token. Every animation has a `prefers-reduced-motion`
fallback: no smooth scroll, no scrubbed scale, the halo draws one static frame,
the chapter loops hold on their posters.

Type is Graphik, self-hosted from `assets/fonts/`, the same faces the roadshow
site uses, with tabular numerals on.

## Redeploying

```bash
# 1. refresh the media from the delivery folder (never writes to it)
tools/sync-assets.sh [delivery-dir] [film-master.mp4]

# 2. or just re-fragment the reel and rewrite film.json
tools/prepare-film.sh

# 3. preview
python3 -m http.server 8791 --bind 127.0.0.1

# 4. ship
git add -A && git commit -m "..." && git push
```

GitHub Pages serves this repo from `main` at `/root`. There is no build step: the
files in the repo are the files that are served.

Budgets the page is held to: first paint under 1 s, hero loop under 3 MB, each
chapter loop under 4 MB, zero layout shift (every media box reserves its
aspect-ratio), zero console errors, no horizontal scroll at any width.
