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
| The gate's left pane: the San Francisco aerial turned tall, full bleed and running, the film's own chevron dead centre at 22% of the pane, its focus-pull arrival, its 4 s breath, and the two-frame strike to white and back | `assets/end/raw.mp4`, the close's own aerial, cropped to the pane's portrait so the gate and the close open and close on one city; and `c360-film/mark/index.html`, the endcard cell: the mark's own path, its rack-in and its strike |
| The gate's right pane: the `Morning.` greeting, the 106 px composer with its 20 px radius, the `Chat \| Cowork` pillbed, the `Fable 5.1 · Medium` meta, the send control | `c360-film/door/index.html`, shots 8 and 9 (measured off the Cowork reference PNGs with PIL) |
| The hero plate: the clean raw aerial the film's shot 1 was cut from, looping, and bare (see The one mark) | `c360-film/overture/assets/video/V1-aerial-push-film-1080p-cut.mp4` |
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

Drawn new, because no source existed: the eleven browser tabs and their favicons,
the modification card, the memo section list, and the plan read-back. All four are
built out of the primitives above and carry no geometry of their own.

## The one mark

The chevron appears **once per screen**, on the `Credit 360` lockup, and nowhere else on
that screen except inside the `accenture` wordmark, which keeps its own because it is the
logo. Counted at 1440x900 and at 390x844, this is what stands on each screen at once:

| Screen | Marks | Why |
|---|---|---|
| Gate | the plate's mark, and the composer's send control | the count is unchanged: the pane's mark used to be the one inside the `accenture` wordmark and is now the chevron standing on its own. The send button is the product's own control, not a decoration |
| Hero | the lockup's | the plate used to carry a second copy dead centre so it cross-faded mark-on-mark into the reel's first frame. It is gone: the film brings its own mark 1.4 s in, and one small mark at the press is cheaper than two on the screen at rest |
| Chapters | the product's own UI only | the `Credit 360 for my book` tab favicon, the `>` on the skill chip, the ask composer's send control. No decorative marks |
| Close | the lockup's, and the wordmark's | the SF plate carries none burned in, and `Watch again` gave its glyph up for a hairline |

The gate is the exception, and it is the reason the device exists: its mark is the one
the visitor strikes to get in. Because that mark is already at full purple, it strikes
the other way, two frames to white and back.

The lockup's mark is the one moment, so it is the one thing that strikes: ink to purple
in the hero, white to purple on the close, two frames each, and nothing else on either
screen is purple except the pin on the map card and, on the gate, the send control.

## The eleven tabs

Chapter 01 is a browser, not a caption about one. The window is the Cowork window's
own chrome seen from outside: the cream titlebar, three lights, a tab strip, an
address bar carrying a real internal Lightning record URL.

The eleven are crammed into one row the way a browser crams them. Every tab is
`flex:1 1 0` with `min-width:0` and a 186 px cap, so at 1440 each one is drawn at
96 px and compresses to a 16 px favicon plus a title the tab itself clips: nCino,
Salesforce, Boom, AFS, IRIS, Snowflake, Outlook, SharePoint, Teams, Spreads.xlsx,
DocMan. The favicons are monochrome 16 px line marks in the product's grey, drawn
for this page because no source existed. The strip never wraps, so it cannot read
as a row of loose words, and the titles are children of the tabs rather than
siblings of them, so it cannot read as a list even with the stylesheet gone.

On a phone there is no paper to compress eleven tabs and still show a letter of
each, so it does what a phone browser does: the tabs hold 108 px, the strip scrolls,
and they overflow in view. That scroller is the one element on the page allowed to
scroll sideways. Because a scrolled strip closes its first tabs off the right edge,
where nobody would see them, the strip travels the row once before the sequence
starts. The closes then sweep it back: scrollLeft is clamped by the shrinking
content, so the return costs no code and every close is watched. Where the eleven
already fit in the row, none of that runs.

The close is the browser's own. On enter, the tabs close from the right 90 ms apart,
each over 260 ms: the closing tab animates its OWN `max-width` to zero, and because
flex re-solves while that width is changing, its siblings re-flow continuously
rather than jumping to their new size. Ten closes run from 380 ms to 1450 ms, or from 900 ms where the strip scrolls first. The
one tab left then widens over 420 ms into a full Cowork tab, swapping its favicon
for the chevron and its title for `Credit 360 for my book`, the address bar drops
from the Lightning URL to `cowork`, and `Not this one.` types under it at the film's
own 24 characters a second.

The window's height is fixed from first paint and no close touches it, so the whole
chapter contributes nothing to the layout-shift ledger. Under reduced motion the
ten are closed, the one has landed and the payoff is set, all without animation.

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

Two panes, because the gate is an entry and should say so: the film's own sky on the
left, the Cowork greeting and the composer on the right. The
greeting is the product's, addressed to the room it opens in: `Morning, San
Francisco.` The composer asks for the passcode by name, and one muted line under it
says who the page is for and where the phrase is: `Invited guests only. The passcode
is on your invitation.` On the right phrase the mark strikes, the dark pane leaves the
frame, and only then does the composer type itself out and run the connectors.
Both pane moves are transforms, so the composer's own box never reflows while the
visitor is looking at it. On a phone the panes stack and the plate takes a short band
at the top. Wrong phrase: the composer moves 2 px, once, and says `Not on the list.`

**The left pane is San Francisco, and it is the close's own aerial.** The door opens
on the city the page ends in, so the gate and the close are one picture seen twice,
the way the hero and the close already are. It is cut from the same
`assets/end/raw.mp4` the close ping-pongs: 3.5 s of it, cropped 750x1072 at x 420 out
of the 1928x1072 frame and scaled to 672x960 for the pane's own portrait. That offset
is the whole framing decision. It puts **Salesforce Tower at 70% of the pane**,
standing its full height and clear of the centred mark, with the Marin headlands
behind it and the Bay Bridge and open water closing the bottom of the frame. A centre
crop puts the tower at 47%, where the chevron's own arm cuts across its shaft; at 70%
the two stop competing and each is read on its own.

The grade is the London plate's curve, unchanged, and it is a **black point rather
than a wash**: +4/255 on red and +8/255 on blue with one step on green, then
saturation 0.94 and contrast 1.03. It moves the shadows cool plum and leaves the mids
and highs alone, which is why the pane sits in the page's register while the light
stays the close's golden hour. The two read as the same city on the same evening.

Slowed 1.6x with motion interpolation and mirrored into an **11.0 s ping-pong**: 132
forward frames, the reverse half trimmed to frames 1..131 so the turnaround drops the
duplicated last frame and the restart drops the duplicated first. Both joins are
single-frame steps, and they are measured rather than assumed: over the finished loop
the turnaround is **2.10** RMS and the restart **1.77**, against a mean of 1.61 and a
p95 of **2.42** for ordinary adjacent frames, with no step anywhere above twice the
mean. Neither join is visible, which is what earns the ping-pong. **949 KB**, crf 24.

The scrim is CSS, not baked, so it tracks the pane at every aspect including the
phone's band; the plate itself stays photographic. It ships `preload="none"` behind
its own first frame as a poster, so the pane is painted before a byte of the loop is
asked for.

**The scrim carries nothing for the mark.** The mark is dead centre, it is lit by its
own drop-shadow, and this plate's centre is haze and lit towers rather than the
darkness the pre-dawn one resolved into: the chevron measures **2.1:1** against it
unaided. So the scrim is reduced to the one job left, seating the pane on the paper at
the bottom edge. It was 45% while a wordmark stood in the lower third, then 22.5% when
the mark went to the centre, and it is **14% at .60** now: the pre-dawn plate resolved
into noise down there and needed covering, and this one ends on open water under the
bridge, which is already calm and already dark.

**Nothing is laid over the top, and the eyebrow is ink.** That was the one real cost of
changing cities. On the pre-dawn aerial the top of the pane was almost black and
`Dreamforce 2026 · A private screening` stood on it in white at .66, at **2.90:1**. San
Francisco puts pale golden sky there, where the same white measures **1.14:1** and is
simply gone. A veil deep enough to put it back reads as a plum slab across the one part
of the plate that is pure light, which is the wash this pane is supposed to avoid; it
was built, looked at, and thrown away. Ink at .74 measures **6.9:1** at 1440x900,
**7.0:1** at 1920x1080 and **6.6:1** on the phone's band, costs the picture nothing, and
is the ink the right-hand pane is already set in, so the two panes are lettered the
same way.

On a phone the band is scaled to its WIDTH, so only a slice of the plate's height
survives, about 37% of it at 208 px and 27% at 148 px. **The band crops to the
tower**: at `object-position: 50% 36%` the window is 23% to 60% of the plate on the
tall band and 26% to 53% on the short one, and the tower stands between 27% and 61%,
so its crown is inside the frame at either end and the band reads as the city rather
than as a strip of sky. The seat is deeper there, 24%, because the band ends mid-city
rather than on the open water the full pane closes on.

The mark on it is the film's own: the single chevron in `#A100FF`, the same `#g-chev`
path the hero lockup is built on and the frame the film opens on, and nothing else.
The pane carried the full `accenture` wordmark set in the lower third; the wordmark
still stands on the close, where it is a signature, but on the door the page should
open on the mark it is going to keep showing.

**It is dead centre on both axes, and the centring is done by layout rather than by
percentages.** `.gmark` is the pane exactly (`inset:0`) and centres its one child in a
grid, so the centre is computed rather than placed and is exact at every viewport.
Measured at the mark's own border box against the pane's: **0.000 px on both axes at
1440x900, 0.008 px horizontally at 1920x1080, 0.008 px vertically at 390x844**: one
1/128 px, which is the browser's own layout-unit rounding and the floor of what can be
measured. The wrapper owns the centring and the mark owns the motion, so the settle's
scale cannot drag the mark off centre: it is scaled about its own centre, which IS the
pane's, and the figure is the same mid-animation as at rest.

It is drawn at 22% of the pane's WIDTH, capped at 160 px: **133.05 px at 1440x900,
160 px (capped) at 1920x1080, 64 px on the phone band**, which is the film's own size
on a 1080 frame. The pane is a tall portrait, so a fraction of its width rather than
its height is what lands the mark at the film's weight.

It arrives on the endcard's focus pull, 6 px of blur and 1.04x of scale resolving over
900 ms, and then breathes between 0.85 and full on a 4 s cycle, so the pane is never
quite still behind the composer. On unlock the strike lands: the wordmark's chevron
used to go half to full purple, and this mark is already at full purple, so the strike
is the other half of the same device, **two frames to white and back**, hard stops so
the colour steps rather than fades. Verified off the animation's own timeline: white at
0, 16 and 32 ms, `#A100FF` from 40 ms.

The scrim under it was the bottom 45% and was a floor for a wordmark set in the lower
third. A floor cannot light a mark at the pane's centre whatever depth it is given, so
it is **halved to 22.5%** (29% on the phone band) and does only what is left to do:
seat the pane on the paper and keep the plate from resolving into noise at the bottom
edge. The mark carries its own contrast instead, on the film's own drop from
`type/OVERLAY.md`. That drop sits on the wrapper rather than on the mark, because
`filter` is a single property and a keyframe setting blur alone would drop the shadow
for the length of the settle; on the wrapper the two compose, and the shadow blurs in
with the mark and breathes with it.

The measurement that made this the right trade: the plate's centre is sky and lit
towers, not the darkness the lower third resolved into. Sampled off the poster where
the mark now sits, the ground is rgb(38,58,76) on the desktop crop and rgb(84,104,121)
on the phone's, whose crop is deliberately biased up to keep a dark top for the
eyebrow and therefore lands the brightest part of the plate behind a centred mark.
Rendered, the mark reads at 1.67:1 against its own ground on the desktop and 1.16:1 on
the phone. Those are luminance ratios and they understate a mark that is separated by
hue and saturation as much as by lightness, which is how a brand mark on a
photographic plate works; the mark is decorative and `aria-hidden`, so no text
threshold applies to it. It reads clearly at all three viewports.

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

A lifted component is whatever size the product makes it, and two of them are
taller than the band the spread leaves beside its reading column. Those are scaled, never
cropped and never given a scrollbar of their own. **The fit rule**: the component is
taken out of flow, centred in the band, and drawn at
`min(1, band / natural, 0.72 * viewport / natural)`, so no card is ever taller than
72% of the screen and every chapter's card lands at the same weight in the frame. The
cap was 62% while the component ran the full width of the page under its caption; in
the spread it has only 62% of the width, so it is allowed the taller band.
Because the component carries no layout height of its own, scaling it can move
nothing else on the page, which is what keeps the fit off the layout-shift ledger.

At 1440x900, natural height, scale, drawn height:

| chapter | column | band | natural | scale | drawn |
|---|---|---|---|---|---|
| a the eleven tabs | 675 | 810 | 354 | 1.000 | 354 |
| b the book | 675 | 809 | 791 | 0.819 | 648 |
| c the integrations | 675 | 810 | 435 | 1.000 | 435 |
| d the relationship | 675 | 809 | 368 | 1.000 | 368 |
| e the sentence | 675 | 809 | 375 | 1.000 | 375 |
| f the memo | 675 | 810 | 633 | 1.000 | 633 |
| g the approve | 675 | 810 | 698 | 0.928 | 648 |

The halo is measured off the dossier's screen rect, so it divides that scale back out
and writes its canvas in the card's own units: the bloom comes out of the transform at
exactly the size it was designed for. The chapter's fit is a transform and a transform
is a stacking context, so the fit itself is what stands above the page dim, and the
plan card goes down with the page by its own hand rather than by the overlay's.

The fit measures HEIGHT only. It was briefly given a width guard as well, in case a
component's own minimum were wider than the 62% column; nothing on the page is, and
the one element that overflows the fit box is the halo's canvas, which is meant to.
The guard was measuring the bloom and pulling chapter 07's card down to 0.80 for it.
It is gone.

The scroller snaps `y proximity`, with `scroll-snap-align: start` on every section: a
section settles into the frame when a gesture ends near one, and a flick still travels
as far as the hand asked. It is proximity and never mandatory. Below 900 px the snap
is off, because below 900 px a chapter is no longer one screen.

**A phone is not a screening room.** Below 900 px the chapters stop being exactly one
screen and become at least one: the component goes back into flow at its own size and
the section grows under it. Scaling the cockpit to 45% to make it fit a 390 px frame
would fit it and lose it. The hero, the breathers and the close stay exactly one
screen everywhere, because what they carry is pictures and type, which do scale.

## The spread, and the facts

At 1080 px and up a chapter is two columns. The reading column takes 38% of the
paper: the chapter counter, the caption in the landing headline, one muted sub, then
the three facts STACKED, a small-caps label over a 40 px figure in tabular ink with
its qualifier at 15 px under it, a hairline between one fact and the next. The lifted
component takes the other 62% and centres against the reading column, its outer edge
on the content margin. At 1440x900 that is 414 px of reading and 675 px of component
with a 63 px gutter between them.

The columns alternate down the page, so the scroll has a rhythm rather than a margin:
01 and 02 read left, 03 reads right, 04 left, 05 right, 06 left. 01 keeps the browser
window on the right it was built in, and 07 keeps its card there too, so the halo's
bloom has the whole reading column of paper to open into.

The facts used to be a thin row of 28 px figures across the top of the chapter, in a
462 px strip beside the caption, with the component standing under them on the left.
That left a wide field of bare cream down the right of every screen and made the
figures read as a footnote to the caption. Two columns spend that paper on the
figures instead. They are the cockpit's own numbers and nothing else.

Under 1080 px the spread closes: the text block goes above, the facts become one row
of the same large figures under it, and the component takes the band below. Under
900 px the figures set at 32 px. Under 560 px they stack again and keep that size,
because three 32 px figures cannot stand across a phone: `$66.50M` alone is wider
than the third of the screen a row would give it.

## The close

One screen, and the only one on the page where the picture carries the type instead of
standing beside it. The picture is no longer the reel's London daylight return; it is
the city they are being asked to come to. `assets/film/sf-plate.mp4` is San Francisco
from altitude at golden hour, the Bay Bridge through the lower third and Salesforce
Tower unmistakable at the centre of the skyline, generated for this page in the same
register as the film's own aerials (from height, city and water, haze, a muted grade).
It is a 5 s image-to-video drift mirrored into a 10.08 s ping-pong at 1600 px, crf 22,
2.34 MB, with its own first frame as the poster. How it was made, which model, what it
cost and what was rejected is in `../assets/end/README.md`.

The picture is dressed with ONE scrim: a single bottom-up gradient, transparent at 45%
of the height and `rgba(20,12,28,.72)` at the floor. No cream wash coming down from the
page above, no top scrim, nothing stacked. Everything on it is white.

The type stands in the lower third on the content margin: `DREAMFORCE 2026` in the
eyebrow at 74% white, the lockup at the hero's own clamp, then `Meet us at the booth.`
in the landing headline. The lockup's chevron strikes here the way it strikes in the
hero: it lands in the type's own white and goes to full purple in two frames, 240 ms
after the close is 55% into the viewport, so the last thing that moves on the page is
the mark.

The place card is the other end of that row. It is the cockpit's own card, standing on
the picture: white, 12 px, one hairline, the dossier's shadow, 420 px wide. Its map is
not a screenshot of somebody's tiles. It is real OpenStreetMap geometry, projected and
drawn as inline SVG in the product's language: cream paper, primary streets at 1.5 px
and everything else at 1 px, FOLSOM, HOWARD, MISSION, 2ND, 3RD and 4TH set along their
own centrelines in the eyebrow style, Moscone Center and Salesforce Tower as light
outlines, north up, and one `--brand` pin on 690 Folsom whose halo opens once when the
close arrives. Under it a single row: `SPIN`, the address, and a hairline `Open in Maps`
that opens Apple Maps in a new tab.

The row is one baseline: `align-items:flex-end` puts the card's bottom edge exactly on
the bottom of the headline's line box. At 1440x900 both land on 792.91, at 1920x1080 on
962.31, and both ends of the row sit on the content margin the film runs to, 48 px at
1440. Under 1080 px there is no paper left for a 420 px card beside a 7vw lockup, so the
card goes full width under the type; under 440 px the address takes its own line under
the venue name rather than being clipped.

The hairline row still keeps the floor of the frame, but it is on the picture now rather
than on paper, so its rule is white at 24% and its ink, the wordmark included, is white
at 70%. `Watch again` carries no glyph: it takes the place card's affordance, a hairline
under the words, because a third mark on this screen is one too many. Nothing of the
plate is fetched until the last chapter leaves.

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
                           plate (the looping pre-dawn aerial and its first frame),
                           the gate plate (the close's San Francisco aerial turned
                           tall for the door's left pane) and the close's own wide
                           San Francisco plate, each with its own first frame
assets/stills/             the three breather frames, cut from the reel
assets/fonts/              Inter 400/500/600 and Newsreader, subset to Latin
assets/vendor/             GSAP and ScrollTrigger. The scroll itself is the browser's.
assets/logos/              the wordmark in white, for the hairline row on the picture
tools/sync-assets.sh       pull the delivered reel in and build the hero plate and
                           the gate plate, the latter from the close's SF source
tools/prepare-film.sh      fragment it for MediaSource and write film.json
```

## Measured

At 1440x900, Chromium, over the local build:

- first contentful paint **116 ms**, load **140 ms**, first film frame **11 ms**
  after the press (the stream is warmed on unlock)
- cumulative layout shift **0.0000** over chapters 02 to the close, at 1440x900,
  1280x800 and 390x844, and no horizontal overflow at any of them. The fit runs at
  load and again on `document.fonts.ready`, while the page is still at the top, and
  the components it scales carry no layout height, so neither pass shifts anything.
  The spread is a grid whose one flexible member is the stage, and the facts arrive
  by opacity and transform, so neither is on the ledger either
- chapter 01 is the exception and is **0.005** at 1440x900, 0.008 at 1280x800. The
  eleven tabs close by animating their own `max-width` to zero so their siblings
  re-flow continuously rather than jumping, which is the browser's own mechanic and
  is the point of the shot, but a width animation IS layout and Chrome counts every
  frame of it. Nothing else on the page shifts. Making it zero means giving up the
  continuous re-flow for a transform, which is a different shot
- every section is exactly 900 px at 1440x900: the document is 11 x 900 = 9900 px of
  scroll and every section's top sits on an exact multiple of it
- a 34-burst trackpad walk over the whole page produced **zero** scroll jumps over
  420 px, and a 12000 px flick travelled its full distance to the end without the
  snap shortening it
- the halo's centre sits on the dossier's centre to within 1 px at every viewport.
  Its light is at true zero **59 px** inside the canvas on all four edges at
  1440x900, 1280x720, 1920x1080 and 390x844 alike. In the spread the card is drawn
  at 0.928 rather than 0.799, so the bloom is bigger than it was and still lands on
  zero with room to spare: at 1440x900 the canvas reaches within 4 px of the frame
  and the light has been out for 55 of them. At the viewport's own edge columns it
  reads 0 at every width
- one frame longer than 25 ms and zero long tasks over the full scroll
- no request over 3 MB besides the reel; the hero plate is 1.19 MB and the gate
  plate is 949 KB
- the gate paints on 12 requests and 760 KB, none of it the pane's loop: the loop
  follows as a 13th request and under `prefers-reduced-motion` it is never asked for
  at all, the poster standing in as the whole plate. (686 KB before the close's own
  poster joined the first paint; re-measured here, the count is unchanged)
- the gate's mark sits on the pane's centre to **0.000 px** at 1440x900, **0.008 px**
  horizontally at 1920x1080 and **0.008 px** vertically at 390x844, measured border
  box against border box. The 0.008 is one 1/128 px, the browser's own layout-unit
  rounding, and the same figure holds mid-settle as at rest. Drawn at 133.05, 160.00
  and 64.00 px
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
spinners stop, the cards arrive flat, the plate holds its first frame, the gate's mark
is simply there with no pull, no breath and no strike, the lines are set rather than
typed, and the halo is lit without breathing. The mark keeps its drop under reduce,
because the drop is paint rather than motion and is the only reason it reads on the
sky.

## Build log
- 2026-09-08: passes landed in order: bloom and native scroll, one-screen chapters and facts, gate skyline plate, eleven tabs, two-column chapter grid, the San Francisco close with the place card, one chevron a screen, the gate's own mark dead centre, and the gate plate cut from the close's own San Francisco aerial so the page opens and closes on one city.
