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
| The gate's left pane: the `>` set large in `#A100FF` on a near-black plum field, the pre-dawn aerial ghosted behind it, the `accenture` wordmark bottom-left, and the two-frame strike to full purple on unlock | `c360-film/mark/index.html`, the endcard cell (the wordmark's own letter paths and its strike), over the overture's plate P1 |
| The gate's right pane: the `Morning.` greeting, the 106 px composer with its 20 px radius, the `Chat \| Cowork` pillbed, the `Fable 5.1 · Medium` meta, the send control | `c360-film/door/index.html`, shots 8 and 9 (measured off the Cowork reference PNGs with PIL) |
| The hero plate: the clean raw aerial the film's shot 1 was cut from, looping, under the page's own chevron at 70% | `c360-film/overture/assets/video/V1-aerial-push-film-1080p-cut.mp4` |
| The breathers: three full-bleed people frames with the film's headline typed over them at 24 characters a second, white with one purple key word and the film's own drop | the reel's own frames at 17.967 s, 44.700 s and 50.000 s, plus `c360-film/type/OVERLAY.md` for the type's rate, colour and shadow |
| The connector rows: the 19 px slot, the coral dashed spinner resolving to the vendor glyph, the 1 px thread, the 14 px label | `c360-film/door/index.html` shot 11 and `c360-film-b/room/index.html` shot 34, including the `Credit Memo · drafting` row |
| The Cowork window chrome and its title bar | the same two cells |
| The context chips and the `>` skill mark | the door cell's rail |
| The landing: the `.kicker` eyebrow, the `.brief h1` headline, the `.card .kpis` metric strip, the `.wlrow` worklist row with its 40 px monogram and `.st` dot chips | the live build, `customer-360-reinvented/app/dist/cockpit.html` |
| The rating ring: `viewBox 0 0 46 46`, `r 19`, stroke 4, circumference 119.4, grade over 8 | the same build's risk-rating anchor |
| The `AI-drafted · Pending reviewer verification` banner and the `Review as drafted` / `Edit narrative` controls | `app/src/memo/vendor/assets/review-shell.js` |
| The `>` mark itself | the Accenture wordmark's own chevron path, not a greater-than glyph |
| The halo | the film's climax at 61 s, where the bloom carries the CARD's own rounded shape rather than a circle behind it, swept through the product's spectrum |
| The film player | the previous build's MediaSource path, unchanged |

Drawn new, because no source existed: the eleven browser tabs, the modification
card, the memo section list, and the plan read-back. All four are built out of the
primitives above and carry no geometry of their own.

## The breathers

Three of the film's own people frames, full bleed, between chapters b/c, e/f and
f/g. Each is a frame the reel carries at 17.967 s, 44.700 s and 50.000 s, cropped
160 px off the left because the film's headline caret is burned into the plate at
x 142 to 148 and every frame of those shots carries it. The still holds a 1.04x
Ken Burns across its own scroll and the film's line types over it at 24 characters
a second, white with one purple key word and the film's `0 2px 18px rgba(0,0,0,.28)`
drop; the payoff types in the film's three beats, each word landing then waiting.
The untyped tail of the line is present but hidden and the caret is moved by
transform alone, so a line that is typing costs nothing in layout.

## The gate

Two panes, because the gate is an entry and should say so: the mark on the film's own
deep field on the left, the Cowork greeting and the composer on the right. The
greeting is the product's, addressed to the room it opens in: `Morning, San
Francisco.` The composer asks for the passcode by name, and one muted line under it
says who the page is for and where the phrase is: `Invited guests only. The passcode
is on your invitation.` On the right phrase the chevron strikes to full purple in two
frames, the dark pane leaves the frame, and only then does the composer type itself
out and run the connectors.
Both pane moves are transforms, so the composer's own box never reflows while the
visitor is looking at it. On a phone the panes stack and the mark takes a short band
at the top. Wrong phrase: the composer moves 2 px, once, and says `Not on the list.`

Client-side only, and a courtesy lock rather than a security boundary: GitHub Pages
serves static files and anyone with the bundle can read `assets/gate.js`. The phrase
itself is never in the repo, only its salted SHA-256. Access is remembered on the
device for 30 days. Append `?lock` to re-lock (booth reset), or call `c360Gate.lock()`.

Nothing heavy is fetched behind the gate. The reel's URL is not in the DOM before
unlock (`film.json` is fetched, and the reel streamed, only after the door sequence
has run) and the hero plate carries `preload="none"` until the same moment.

## The halo

The halo is the one piece of spectacle on the page and it has to sit exactly on the
card. Its canvas is the dossier's own measured box inflated by one pad, so its centre
IS the card's centre at every viewport, and what it strokes is the card's own rounded
edge rather than a circle behind it.

**The pad is the whole thing.** The bloom wants a canvas 2.4x the card wide and 3x it
tall, and it takes as much of that as the paper allows. It never takes more: the pad
is capped by the viewport on the sides and by the plan card above and the endcard
below, so the light is always at true zero before it reaches anything that could cut
it. The light's support is `E + line/2 + 3 sigma`, set equal to the pad less a dead
band of 44 px (or 28% of the pad, whichever is smaller, so a phone still gets a
bloom). Line over sigma is held at 2.4, which is what keeps the bloom a body of light
rather than a smear as the pad changes size. Below 1140 px the chapter's stage pulls
in and the two cards narrow together, because a bloom can only be painted where there
is paper.

Peak is capped at 0.42 so the dossier's type stays fully legible, and the sweep is
the film's spectrum taken one step off full saturation. The surface goes down one
stop first, the bloom rises over 900 ms, then it breathes at 4 s.

Nothing on the page clips horizontally except `html, body`. A section carrying
`overflow-x: clip` slices the bloom flat at its own left and right edges, and on a
phone that is exactly what happened: the light read 102 of 255 at the screen's
outermost column and stopped there.

## One screen

Every section on the page is exactly one viewport: the hero, the seven chapters, the
three breathers and the close. Nothing bleeds into the next thing and nothing has to
be scrolled inside itself to be read. The height is `--vph`, measured once per WIDTH
and never touched again, because `100vh` is not stable on a phone: the browser chrome
collapses on the first gesture and every full-height section would reflow mid-scroll.

The hero holds the lockup, the line and the film in that one screen. The film is the
only elastic member of the column: `#film` is a size container and the player takes
`min(100cqh, 100cqw * 9 / 16)`, so it comes down in SIZE to fit the band the head
leaves it and never in shape. At 1440x900 it lands at 1166 x 656.

A lifted component is whatever size the product makes it, and three of them are
taller than the band a chapter leaves under its caption. Those are scaled, never
cropped and never given a scrollbar of their own. **The fit rule**: the component is
taken out of flow, centred in the band, and drawn at
`min(1, band / natural, 0.62 * viewport / natural)`, so no card is ever taller than
62% of the screen and every chapter's card lands at the same weight in the frame.
Because the component carries no layout height of its own, scaling it can move
nothing else on the page, which is what keeps the fit off the layout-shift ledger.

At 1440x900, natural height, scale, drawn height:

| chapter | band | natural | scale | drawn |
|---|---|---|---|---|
| a the eleven tabs | 609 | 114 | 1.000 | 114 |
| b the book | 653 | 658 | 0.848 | 558 |
| c the integrations | 564 | 435 | 1.000 | 435 |
| d the relationship | 653 | 484 | 1.000 | 484 |
| e the sentence | 653 | 318 | 1.000 | 318 |
| f the memo | 654 | 633 | 0.882 | 558 |
| g the approve | 654 | 698 | 0.799 | 558 |

The halo is measured off the dossier's screen rect, so it divides that scale back out
and writes its canvas in the card's own units: the bloom comes out of the transform at
exactly the size it was designed for. The chapter's fit is a transform and a transform
is a stacking context, so the fit itself is what stands above the page dim, and the
plan card goes down with the page by its own hand rather than by the overlay's.

The scroller snaps `y proximity`, with `scroll-snap-align: start` on every section: a
section settles into the frame when a gesture ends near one, and a flick still travels
as far as the hand asked. It is proximity and never mandatory. Below 900 px the snap
is off, because below 900 px a chapter is no longer one screen.

**A phone is not a screening room.** Below 900 px the chapters stop being exactly one
screen and become at least one: the component goes back into flow at its own size and
the section grows under it. Scaling the cockpit to 45% to make it fit a 390 px frame
would fit it and lose it. The hero, the breathers and the close stay exactly one
screen everywhere, because what they carry is pictures and type, which do scale.

## The facts

Each chapter carries a second layer beside its caption, on the paper the caption
leaves to its right: three of the product's own stat tiles, a small-caps label over
either a 28 px figure or one 15 px line, divided by hairlines. They are the cockpit's
own figures and nothing else. Under 1080 px they move below the component; under
900 px they set smaller. The column is held at 462 px, the width three of the
product's figures need at 28 px.

## The close

One screen, and the only one on the page where the film's own picture carries the type
instead of standing beside it. `assets/film/hero-aerial-day.mp4` is the reel's daylight
return, cut at 68.75 to 69.79 s where the shot is at full brightness between its own
two fades, interpolated to 72 fps, stretched 3x and mirrored into a 6.42 s ping-pong at
1600 px, 1.20 MB. It carries the chevron at full strength dead centre, which is the mark
the page opened on, so the close lands on the frame it started from. It drifts 1.03x
over 28 s. The paper does not stop at the section's top edge, it dissolves into the
picture over the top 52%, and the lockup stands in the cream where it is still paper,
at the hero's own clamp. Under it: `Meet us at the booth.` in the landing headline, then
the address and the show in the eyebrow. The cream comes back up under the bottom 22%
so the ink on the hairline row still reads, and that row keeps the bottom of the frame
however tall the screen is. Nothing of it is fetched until the last chapter leaves.

## The motion

One language, and it is the product's own arrival: **240 ms of opacity over an 8 px
rise on `cubic-bezier(.2,.7,.2,1)`**, members of one card 40 ms apart, every cue
fired once when its element is 20% into the viewport. Typing is 24 characters a
second everywhere: the gate's prompt, the ask, the three breather lines. Figures roll
for 600 ms. Nothing runs longer than 900 ms except the halo's bloom, and no chapter's
whole reveal runs past about a second, so a component is always finished before its
section has left the screen. The cards used to arrive out of a `rotateY(-6deg)` tilt;
against a still page that read as a hinge, not as the film, and it is gone.

The scroll is the browser's own. This page used to run Lenis over the top of it; on a
trackpad that is a lerp fighting the pointer's own inertia, and every cue lands
behind the scroll it belongs to. Driven with identical wheel events, Lenis delivered
13.4 px of each 54 px the wheel asked for and paid the rest back as a tail, over 21
frames longer than 25 ms across the page. Native: 53.7 px delivered, one frame over
25 ms, zero long tasks.

## Structure

```
index.html                 the page: one file, one <style>, one <script>
assets/gate.js             the door, loaded synchronously in <head>
assets/film/               the reel (1080p + 720p, fragmented), film.json, the hero
                           plate (the looping pre-dawn aerial and its first frame)
                           and the close's daylight aerial and its first frame
assets/stills/             the three breather frames, cut from the reel
assets/fonts/              Inter 400/500/600 and Newsreader, subset to Latin
assets/vendor/             GSAP and ScrollTrigger. The scroll itself is the browser's.
assets/logos/              the wordmark, recoloured to ink for the cream ground
tools/sync-assets.sh       pull the delivered reel in and build the hero plate
tools/prepare-film.sh      fragment it for MediaSource and write film.json
```

## Measured

At 1440x900, Chromium, over the local build:

- first contentful paint **116 ms**, load **140 ms**, first film frame **11 ms**
  after the press (the stream is warmed on unlock)
- cumulative layout shift **0.0000** over the whole scroll, at 1440x900, 1920x1080
  and 390x844, and no horizontal overflow at 390. The fit runs at load and again on
  `document.fonts.ready`, while the page is still at the top, and the components it
  scales carry no layout height, so neither pass shifts anything
- every section is exactly 900 px at 1440x900: the document is 11 x 900 = 9900 px of
  scroll and every section's top sits on an exact multiple of it
- a 34-burst trackpad walk over the whole page produced **zero** scroll jumps over
  420 px, and a 12000 px flick travelled its full distance to the end without the
  snap shortening it
- the halo's centre sits on the dossier's centre to within 1 px at every viewport.
  Its light is at true zero **73 px** inside the canvas at 1440x900, 67 px at
  1280x720, 77 px at 1920x1080 and 19 px at 390x844, on all four edges, worst
  single-pixel step 4 of 255. At the viewport's own edge columns it reads 0 at
  every width
- one frame longer than 25 ms and zero long tasks over the full scroll
- no request over 3 MB besides the reel; the hero plate is 1.19 MB
- 0 console errors, 0 failed requests, no horizontal overflow

The reel in `assets/film/` is the rev 4 master. Its FILE md5 does not match the
delivered master's, and is not meant to: `tools/prepare-film.sh` rewrites the
container in place with `-c copy -movflags +frag_keyframe+empty_moov+default_base_moof`
so MediaSource can start on the first seconds. Both elementary streams are
bit-identical to the delivery, and that is the check to run:

```
ffmpeg -v error -i <file> -map 0:v -c copy -f md5 -   # 5329b5cbf3ab6c6d3de6cb67cedc8a28
ffmpeg -v error -i <file> -map 0:a -c copy -f md5 -   # a8b9262c929aa8462d0ab4b0103e77b1
```

Reduced motion is respected throughout: every entrance resolves instantly, the
spinners stop, the cards arrive flat, the plate holds its first frame, the lines
are set rather than typed, and the halo is lit without breathing.
