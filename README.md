# Credit 360 · a private screening

One page. Cream paper, ink text, Inter, hairlines, and one accent: the Accenture
chevron in `#A100FF`. **The page is the product.** Every surface on it is the Credit
360 cockpit's own, so the site and the film it carries are the same object seen twice.

Live: <https://cowork-offering.github.io/credit360/>

## What is lifted, and from where

Nothing on this page was designed for it. Each component was taken off a real
surface and rebuilt as live HTML at its real scale:

| On the page | Lifted from |
|---|---|
| The gate: the `Morning.` greeting, the 106 px composer with its 20 px radius, the `Chat \| Cowork` pillbed, the `Fable 5.1 · Medium` meta, the send control | `c360-film/door/index.html`, shots 8 and 9 (measured off the Cowork reference PNGs with PIL) |
| The connector rows: the 19 px slot, the coral dashed spinner resolving to the vendor glyph, the 1 px thread, the 14 px label | `c360-film/door/index.html` shot 11 and `c360-film-b/room/index.html` shot 34, including the `Credit Memo · drafting` row |
| The Cowork window chrome and its title bar | the same two cells |
| The context chips and the `>` skill mark | the door cell's rail |
| The landing: the `.kicker` eyebrow, the `.brief h1` headline, the `.card .kpis` metric strip, the `.wlrow` worklist row with its 40 px monogram and `.st` dot chips | the live build, `customer-360-reinvented/app/dist/cockpit.html` |
| The rating ring: `viewBox 0 0 46 46`, `r 19`, stroke 4, circumference 119.4, grade over 8 | the same build's risk-rating anchor |
| The `AI-drafted · Pending reviewer verification` banner and the `Review as drafted` / `Edit narrative` controls | `app/src/memo/vendor/assets/review-shell.js` |
| The `>` mark itself | the Accenture wordmark's own chevron path, not a greater-than glyph |
| The halo | the film's climax, as a conic sweep through the product's spectrum |
| The film player | the previous build's MediaSource path, unchanged |

Drawn new, because no source existed: the eleven browser tabs, the modification
card, the memo section list, and the plan read-back. All four are built out of the
primitives above and carry no geometry of their own.

## The gate

Client-side only, and a courtesy lock rather than a security boundary: GitHub Pages
serves static files and anyone with the bundle can read `assets/gate.js`. The phrase
itself is never in the repo, only its salted SHA-256. Access is remembered on the
device for 30 days. Append `?lock` to re-lock (booth reset), or call `c360Gate.lock()`.

The reel's URL is not in the DOM before unlock: `film.json` is fetched, and the reel
streamed, only after the door sequence has run.

## Structure

```
index.html                 the page: one file, one <style>, one <script>
assets/gate.js             the door, loaded synchronously in <head>
assets/film/               the reel (1080p + 720p, fragmented), poster, film.json
assets/fonts/              Inter 400/500/600 and Newsreader, subset to Latin
assets/vendor/             GSAP, ScrollTrigger, Lenis
assets/logos/              the wordmark, recoloured to ink for the cream ground
tools/sync-assets.sh       pull the delivered reel in
tools/prepare-film.sh      fragment it for MediaSource and write film.json
```

## Measured

At 1440x900, Chromium, over the local build:

- first contentful paint **104 ms**, load **105 ms**, 9 requests, 445 KB
- first film frame **8 ms** after the press (the stream is warmed on unlock)
- cumulative layout shift **0.0000** over the whole scroll
- 0 console errors, 0 failed requests, at 1440x900 and 390x844

Reduced motion is respected throughout: every entrance resolves instantly, the
spinners stop, the halo is lit without breathing.
