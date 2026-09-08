/* ============================================================
   CREDIT 360. THE INVITATION.
   Loaded synchronously in <head>. If the visitor holds no valid unlock the page
   is hidden from first paint (no flash) and a black pane covers the viewport
   with one purple chevron and one hairline field. The right phrase makes the
   chevron strike and the black lifts.

   Client-side only. This is a courtesy lock for an invited audience, not a
   security boundary: GitHub Pages serves static files and anyone with the
   bundle can read this script. The phrase itself is never in the repo, only
   the salted SHA-256 of it. Access is remembered on this device for 30 days.
   Append ?lock to any URL to re-lock (booth reset), or call c360Gate.lock().
   ============================================================ */
(function () {
  var KEY = 'c360.gate.v1';
  var SALT = 'c360-premiere:';
  var HASH = 'e324137a08515de0a585f28b33865b7d02e7ccf129d1b0e1675653162e40b508';
  var TTL = 30 * 24 * 3600 * 1000;
  var root = document.documentElement;
  var RM = window.matchMedia && window.matchMedia('(prefers-reduced-motion: reduce)').matches;

  function lock() {
    try { localStorage.removeItem(KEY); } catch (e) {}
    location.href = location.pathname;
  }
  function unlocked() {
    try {
      var v = JSON.parse(localStorage.getItem(KEY) || 'null');
      return !!(v && v.h === HASH && v.t > Date.now());
    } catch (e) { return false; }
  }
  try { if (/[?&]lock(=|&|$)/.test(location.search)) { localStorage.removeItem(KEY); } } catch (e) {}

  var waiters = [];
  var api = {
    locked: !unlocked(),
    lock: lock,
    whenOpen: function (fn) { if (api.locked) { waiters.push(fn); } else { fn(); } }
  };
  window.c360Gate = api;
  if (!api.locked) { return; }

  /* ---- critical CSS: hide the page from first paint, no flash ---- */
  root.classList.add('gate-locked');
  var crit = document.createElement('style');
  crit.textContent =
    'html.gate-locked{overflow:hidden!important;background:#000}' +
    'html.gate-locked body>*:not(#c360-gate){visibility:hidden!important}';
  document.head.appendChild(crit);

  /* ---- SHA-256 (WebCrypto, with a pure-JS fallback for file:// previews) ---- */
  function sha256js(str) {
    var K = [0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2];
    var H = [0x6a09e667,0xbb67ae85,0x3c6ef372,0xa54ff53a,0x510e527f,0x9b05688c,0x1f83d9ab,0x5be0cd19];
    var b = unescape(encodeURIComponent(str)), l = b.length, w = [], i;
    for (i = 0; i < l; i++) { w[i >> 2] |= b.charCodeAt(i) << (24 - (i % 4) * 8); }
    w[l >> 2] |= 0x80 << (24 - (l % 4) * 8);
    w[((l + 8 >> 6) << 4) + 15] = l * 8;
    var W = new Array(64), r = function (x, n) { return (x >>> n) | (x << (32 - n)); };
    for (var j = 0; j < w.length; j += 16) {
      var a = H[0], bb = H[1], c = H[2], d = H[3], e = H[4], f = H[5], g = H[6], h = H[7], t;
      for (t = 0; t < 64; t++) {
        W[t] = t < 16 ? (w[j + t] | 0) : ((r(W[t-2],17) ^ r(W[t-2],19) ^ (W[t-2] >>> 10)) + W[t-7] + (r(W[t-15],7) ^ r(W[t-15],18) ^ (W[t-15] >>> 3)) + W[t-16]) | 0;
        var T1 = (h + (r(e,6) ^ r(e,11) ^ r(e,25)) + ((e & f) ^ (~e & g)) + K[t] + W[t]) | 0;
        var T2 = ((r(a,2) ^ r(a,13) ^ r(a,22)) + ((a & bb) ^ (a & c) ^ (bb & c))) | 0;
        h = g; g = f; f = e; e = (d + T1) | 0; d = c; c = bb; bb = a; a = (T1 + T2) | 0;
      }
      H[0]=(H[0]+a)|0; H[1]=(H[1]+bb)|0; H[2]=(H[2]+c)|0; H[3]=(H[3]+d)|0; H[4]=(H[4]+e)|0; H[5]=(H[5]+f)|0; H[6]=(H[6]+g)|0; H[7]=(H[7]+h)|0;
    }
    return H.map(function (x) { return ('00000000' + (x >>> 0).toString(16)).slice(-8); }).join('');
  }
  function digest(str) {
    if (window.crypto && crypto.subtle && window.TextEncoder) {
      return crypto.subtle.digest('SHA-256', new TextEncoder().encode(str)).then(function (buf) {
        return Array.prototype.map.call(new Uint8Array(buf), function (x) { return ('0' + x.toString(16)).slice(-2); }).join('');
      }).catch(function () { return sha256js(str); });
    }
    return Promise.resolve(sha256js(str));
  }

  /* ---- the pane: black, one chevron, one hairline ---- */
  var css =
  '#c360-gate{position:fixed;inset:0;z-index:2147483000;background:#000;color:#F1F1EF;overflow:hidden;' +
    'font-family:"Graphik","Helvetica Neue",Arial,sans-serif;-webkit-font-smoothing:antialiased;' +
    'display:flex;align-items:center;justify-content:center;' +
    '--g-violet:#A100FF;--g-silk:cubic-bezier(.16,1,.3,1)}' +
  '#c360-gate *{box-sizing:border-box;margin:0}' +
  /* the bloom the chevron sits in */
  '#c360-gate .g-bloom{position:absolute;inset:0;pointer-events:none;opacity:0;transition:opacity 1.2s ease .2s;' +
    'background:radial-gradient(30vmax 22vmax at 50% 50%,rgba(161,0,255,.17),rgba(161,0,255,0) 66%)}' +
  '#c360-gate.in .g-bloom{opacity:1}' +
  '#c360-gate .g-card{position:absolute;inset:0;opacity:0;transition:opacity 1.1s var(--g-silk) .1s}' +
  '#c360-gate.in .g-card{opacity:1}' +
  '#c360-gate .g-mark{position:absolute;left:50%;top:50%;transform:translate(-50%,-50%);' +
    'width:1ch;height:64px;display:grid;place-items:center}' +
  '#c360-gate form{position:absolute;left:50%;top:calc(50% + clamp(74px,11vh,116px));' +
    'transform:translateX(-50%);width:min(340px,calc(100vw - 48px));text-align:center}' +
  /* the chevron: 64px, dead centre, breathing at 4s */
  '#c360-gate .g-chev{display:block;font-size:64px;line-height:1;font-weight:600;color:var(--g-violet);' +
    'opacity:.72;animation:gBreathe 4s ease-in-out infinite;' +
    'transition:opacity .18s linear,text-shadow .18s linear,transform .5s var(--g-silk)}' +
  '@keyframes gBreathe{0%,100%{opacity:.62;transform:scale(1)}50%{opacity:.86;transform:scale(1.035)}}' +
  '#c360-gate .g-chev.dim{animation:none;opacity:.24}' +
  '#c360-gate .g-chev.strike{animation:none;opacity:1;text-shadow:0 0 44px rgba(161,0,255,.85),0 0 14px rgba(161,0,255,.6)}' +
  /* the one field */
  '#c360-gate .g-field{position:relative;padding-bottom:10px}' +
  '#c360-gate .g-field::after{content:"";position:absolute;left:0;right:0;bottom:0;height:1px;' +
    'background:rgba(255,255,255,.22);transition:background .3s ease}' +
  '#c360-gate .g-field::before{content:"";position:absolute;left:0;bottom:0;height:1px;width:100%;background:var(--g-violet);' +
    'z-index:1;transform:scaleX(0);transform-origin:center;transition:transform .7s var(--g-silk);' +
    'box-shadow:0 0 14px rgba(161,0,255,.5)}' +
  '#c360-gate .g-field:focus-within::before{transform:scaleX(1)}' +
  '#c360-gate input{width:100%;background:transparent;border:0;outline:0;color:inherit;font:inherit;' +
    'font-size:17px;font-weight:300;letter-spacing:.14em;text-align:center;padding:8px 0;caret-color:var(--g-violet)}' +
  '#c360-gate input::placeholder{color:rgba(241,241,239,.32);font-weight:300;letter-spacing:.16em}' +
  '#c360-gate input:-webkit-autofill{-webkit-text-fill-color:#fff;-webkit-box-shadow:0 0 0 1000px #000 inset;transition:background-color 9999s}' +
  '#c360-gate .g-sr{position:absolute;width:1px;height:1px;overflow:hidden;clip:rect(0 0 0 0);white-space:nowrap}' +
  /* wrong phrase: 2px, once */
  '@keyframes gShake{0%,100%{transform:translateX(0)}25%{transform:translateX(-2px)}50%{transform:translateX(2px)}75%{transform:translateX(-2px)}}' +
  '#c360-gate form.shake{animation:gShake .26s linear 1}' +
  /* right phrase: the black lifts */
  '#c360-gate.open{pointer-events:none;opacity:0;transform:translateY(-1.5vh);' +
    'transition:opacity .6s cubic-bezier(.4,0,.2,1),transform .6s cubic-bezier(.4,0,.2,1)}' +
  '#c360-gate.open .g-card{opacity:0;transition:opacity .28s ease}' +
  '@media(prefers-reduced-motion:reduce){#c360-gate .g-chev{animation:none;opacity:.8}' +
    '#c360-gate form.shake{animation:none}#c360-gate .g-card,#c360-gate .g-bloom{transition-duration:.2s}' +
    '#c360-gate.open{transition-duration:.2s;transform:none}}';

  function mount() {
    var st = document.createElement('style'); st.textContent = css; document.head.appendChild(st);
    var g = document.createElement('div');
    g.id = 'c360-gate';
    g.setAttribute('role', 'dialog');
    g.setAttribute('aria-modal', 'true');
    g.setAttribute('aria-label', 'Invitation');
    g.innerHTML =
      '<div class="g-bloom" aria-hidden="true"></div>' +
      '<div class="g-card">' +
        '<span class="g-mark" aria-hidden="true"><span class="g-chev">&gt;</span></span>' +
        '<form novalidate autocomplete="off">' +
          '<label class="g-sr" for="c360-inv">Invitation</label>' +
          '<div class="g-field">' +
            '<input id="c360-inv" type="password" placeholder="Invitation" autocapitalize="off" ' +
              'autocorrect="off" spellcheck="false" autocomplete="off" aria-describedby="c360-inv-msg" />' +
          '</div>' +
          '<button type="submit" class="g-sr">Enter</button>' +
          '<p id="c360-inv-msg" class="g-sr" role="status" aria-live="polite"></p>' +
        '</form>' +
      '</div>';
    document.body.appendChild(g);

    var form = g.querySelector('form'), input = g.querySelector('input'),
        chev = g.querySelector('.g-chev'), msg = g.querySelector('#c360-inv-msg');

    requestAnimationFrame(function () { requestAnimationFrame(function () {
      g.classList.add('in');
      setTimeout(function () { try { input.focus({ preventScroll: true }); } catch (e) {} }, RM ? 40 : 420);
    }); });

    input.addEventListener('input', function () { chev.classList.remove('dim'); msg.textContent = ''; });

    var busy = false;
    form.addEventListener('submit', function (ev) {
      ev.preventDefault();
      if (busy) { return; }
      var v = input.value.trim();
      if (!v) { input.focus(); return; }
      busy = true;
      digest(SALT + v.toLowerCase()).then(function (h) {
        busy = false;
        if (h === HASH) { open(); return; }
        chev.classList.add('dim');
        msg.textContent = 'Not on the list.';
        form.classList.remove('shake'); void form.offsetWidth; form.classList.add('shake');
        input.select();
      });
    });

    function open() {
      try { localStorage.setItem(KEY, JSON.stringify({ h: HASH, t: Date.now() + TTL })); } catch (e) {}
      input.blur();
      /* the strike: 2 frames to full purple, then the black lifts over 600ms */
      chev.classList.remove('dim');
      chev.classList.add('strike');
      setTimeout(function () {
        api.locked = false;
        root.classList.remove('gate-locked');
        g.classList.add('open');
        window.dispatchEvent(new CustomEvent('gate:unlocked'));
        var w = waiters.splice(0);
        for (var i = 0; i < w.length; i++) { try { w[i](); } catch (e) {} }
        setTimeout(function () { g.remove(); crit.remove(); st.remove(); }, RM ? 240 : 700);
      }, RM ? 60 : 340);
    }
  }

  if (document.readyState === 'loading') { document.addEventListener('DOMContentLoaded', mount); }
  else { mount(); }
})();
