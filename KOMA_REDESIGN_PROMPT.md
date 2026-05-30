# KOMA — Prompt Redesign Complet
*Basé sur l'analyse du code réel + conseils des experts (Aura transcripts)*

---

## 🇬🇧 PROMPT FINAL (en anglais — à coller dans Claude)

---

You are a senior UX/UI designer and frontend engineer. You are redesigning an existing 9-page website for KOMA — a premium construction project management platform for the African diaspora.

The existing pages are: home.html, solutions.html, journey.html, platform.html, projects.html, partners.html, about.html, contact.html, index.html.

You have full access to the existing HTML. Your job is NOT to rewrite from scratch — it is to perform a surgical, high-quality redesign that fixes specific problems identified by expert reviewers and elevates the visual quality without touching the content, internal links, or data.

---

## PROBLEM DIAGNOSIS — WHAT THE EXPERTS SAY

The current site has 3 critical problems identified by design experts:

**Problem 1 — DOUBLE NAVBAR (unprofessional)**
There are two stacked nav bars: a `.nav-audience-bar` (46px) + a `.nav-main-bar` (54px) = 100px of navigation. This is visually heavy, amateur, and kills first impressions. Expert quote: "you can tell when a UI is AI generated — the baseline is too predictable." The Uber-style double bar concept is sound, but the current execution stacks them like two separate UI components with no visual fusion.

**Problem 2 — TYPOGRAPHY (AI smell)**
Everything uses Inter at weight 900 (headings) and 700 (subheadings). Expert quote: "titles are too bold, there's too much letter spacing, it's always the same font, devoid of personality." The current site smells like AI because of this. Inter is the default AI font. The letter-spacing on `.koma-word` (0.09em) looks forced.

**Problem 3 — NO ANIMATIONS / NO SCROLL BEHAVIOR**
The site is completely static. Expert quote: "the baseline is much higher now — interactions with the scrolling behavior" and "we're going to have amazing hero sections with a lot of new typography." Nothing enters the viewport elegantly. There's no personality in motion. The tracker widget, the step cards, the testimonials — all appear dead on load.

---

## DESIGN SYSTEM — PRESERVE THESE EXACTLY

These CSS custom properties MUST NOT change in name or value:

```css
--teal: #45C9BF
--teal-dark: #2EAFA5
--teal-sky: #6DCEFC
--teal-mint: #69EBD1
--teal-pale: #E8F9F6
--teal-soft: #B8EEE5
--night: #0B1F23
--night-2: #0F2A2C
--gold: #C19A4B
--gold-soft: #D9BB7B
--grad-cta: linear-gradient(135deg, #6DCEFC 0%, #69EBD1 100%)
--ink: #0F0F0F
--body: #4A4A4A
--stone: #888888
--white: #FFFFFF
--paper: #F7FFFE
--light: #F4F4F4
--rule: #E8E8E8
--maxw: 1280px
--gut: clamp(20px, 4vw, 64px)
--section-y: clamp(64px, 8vw, 120px)
--r-pill: 999px
--r-md: 12px
--r-lg: 20px
--r-xl: 28px
```

---

## FIX 1 — UNIFIED SINGLE NAVBAR (apply to ALL 9 pages)

**Replace the current 2-row navbar with a single unified navigation bar.**

The current structure:
```
.nav-audience-bar (46px, #111) — brand + audience tabs + WeCare + lang + CTA
.nav-main-bar (54px, #1A1A1A) — nav links + secondary CTAs
```

The new structure: **one single bar, 64px height, background #0F0F0F.**

Layout: `[KOMA logo] [divider] [Pour les clients / Pour les pros tabs] [spacer flex] [Solutions · Comment ça marche · Plateforme · Projets · À propos] [WeCare pill] [Estimer mon projet button]`

CSS rules for the new unified nav:
```css
.site-header {
  position: sticky;
  top: 0;
  z-index: 200;
  background: #0F0F0F;
  border-bottom: 1px solid rgba(255,255,255,0.07);
  backdrop-filter: blur(12px);
}

.nav-unified {
  height: 64px;
  display: flex;
  align-items: center;
  gap: 0;
  width: 100%;
  max-width: var(--maxw);
  margin: 0 auto;
  padding: 0 var(--gut);
}

/* Logo */
.nav-brand .koma-word {
  font-family: var(--f-display);
  font-weight: 800;
  font-size: 18px;
  letter-spacing: 0.14em;
  color: #fff;
  line-height: 1;
}
.nav-brand .koma-sub {
  font-size: 7px;
  font-weight: 500;
  letter-spacing: 0.35em;
  color: rgba(255,255,255,0.4);
  text-transform: uppercase;
  margin-top: 3px;
}

/* Divider after logo */
.nav-divider {
  width: 1px;
  height: 20px;
  background: rgba(255,255,255,0.12);
  margin: 0 20px;
  flex-shrink: 0;
}

/* Audience tabs — compact, same row */
.aud-tabs {
  display: flex;
  height: 100%;
  margin-right: 20px;
}
.aud-tab {
  height: 100%;
  display: flex;
  align-items: center;
  padding: 0 14px;
  font-size: 12px;
  font-weight: 600;
  letter-spacing: 0.04em;
  color: rgba(255,255,255,0.45);
  border-bottom: 2px solid transparent;
  transition: color 0.15s, border-color 0.15s;
  white-space: nowrap;
}
.aud-tab.active {
  color: #fff;
  border-bottom-color: var(--teal);
}
.aud-tab:hover { color: rgba(255,255,255,0.8); }

/* Main nav links */
.nav-links {
  display: flex;
  align-items: center;
  height: 100%;
  flex: 1;
}
.nav-item {
  height: 100%;
  display: flex;
  align-items: center;
  padding: 0 14px;
  font-size: 13px;
  font-weight: 500;
  color: rgba(255,255,255,0.60);
  white-space: nowrap;
  transition: color 0.15s;
  position: relative;
}
.nav-item::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 14px;
  right: 14px;
  height: 2px;
  background: var(--teal);
  border-radius: 2px 2px 0 0;
  transform: scaleX(0);
  transform-origin: left;
  transition: transform 0.2s ease;
}
.nav-item:hover { color: #fff; }
.nav-item:hover::after,
.nav-item.active::after { transform: scaleX(1); }
.nav-item.active { color: #fff; }

/* Right cluster */
.nav-right {
  display: flex;
  align-items: center;
  gap: 8px;
  flex-shrink: 0;
  padding-left: 16px;
}

/* WeCare pill — gold accent */
.nav-wecare {
  font-size: 11px;
  font-weight: 600;
  color: var(--gold-soft);
  background: rgba(193,154,75,0.08);
  border: 1px solid rgba(193,154,75,0.25);
  padding: 5px 12px;
  border-radius: var(--r-pill);
  transition: 0.15s;
  letter-spacing: 0.04em;
}
.nav-wecare:hover {
  background: rgba(193,154,75,0.16);
  color: var(--gold);
}
```

**Mobile (max-width: 980px):** Collapse all nav links and audience tabs. Show only: logo + hamburger icon (☰) on the right. The WeCare pill becomes the mobile CTA.

**Remove completely:** `.nav-audience-bar` class, `.nav-main-bar` class, `.mega-panel`, `.mega-grid`, `.mega-link` (the dropdown mega-menu adds complexity without value at this stage).

---

## FIX 2 — TYPOGRAPHY OVERHAUL (apply to ALL 9 pages)

**Replace Inter with this pairing:**

```html
<!-- In <head>, replace the existing Google Fonts link with: -->
<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@600;700&family=DM+Sans:wght@400;500;600;700&display=swap" rel="stylesheet">
```

**Font assignment:**
```css
--f-display: 'Cormorant Garamond', Georgia, serif;
--f-body: 'DM Sans', system-ui, sans-serif;
```

**Heading rewrites:**
```css
h1 {
  font-family: var(--f-display);
  font-size: clamp(44px, 6.5vw, 88px);
  font-weight: 700;
  line-height: 1.02;
  letter-spacing: -0.02em;
  color: var(--ink);
  text-wrap: balance;
}

h2 {
  font-family: var(--f-display);
  font-size: clamp(30px, 4vw, 56px);
  font-weight: 700;
  line-height: 1.06;
  letter-spacing: -0.018em;
  color: var(--ink);
  text-wrap: balance;
}

h3 {
  font-family: var(--f-body);
  font-size: clamp(20px, 2vw, 24px);
  font-weight: 600;
  line-height: 1.2;
  letter-spacing: -0.01em;
}

h4 {
  font-family: var(--f-body);
  font-size: 17px;
  font-weight: 600;
  line-height: 1.25;
  letter-spacing: -0.005em;
}
```

**Logo (KOMA wordmark):**
```css
.koma-word {
  font-family: var(--f-body);
  font-weight: 700;
  font-size: 18px;
  letter-spacing: 0.14em;
  /* Keep this in DM Sans — logos should not use display serifs */
}
```

**Step numbers:** Keep the gradient text treatment but reduce from font-size 48px to 42px, weight stays at 900 (this is decorative, not a heading).

**Testimonial blockquotes:**
```css
blockquote {
  font-family: var(--f-display);
  font-weight: 600;
  font-size: clamp(17px, 1.6vw, 20px);
  line-height: 1.5;
  font-style: italic;
  color: var(--ink);
}
```

**Dark section headings** (`.sec-dark h2`, `.wecare-section h2`): Keep font-family var(--f-display), add `color: #fff`.

---

## FIX 3 — SCROLL ANIMATIONS (apply to ALL 9 pages)

Add this JS block before `</body>` on every page:

```javascript
<script>
/* KOMA — Scroll reveal system */
(function() {
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

  const style = document.createElement('style');
  style.textContent = `
    .reveal {
      opacity: 0;
      transform: translateY(22px);
      transition: opacity 0.65s ease, transform 0.65s ease;
    }
    .reveal.visible {
      opacity: 1;
      transform: translateY(0);
    }
  `;
  document.head.appendChild(style);

  /* Apply to specific elements */
  const targets = document.querySelectorAll(
    '.card, .sec-head, .tracker, figure, .imgph, .kpi, .stage, .feed-item, .wecare-section .lead, .wecare-section h2, .step-num, .stat-big'
  );

  targets.forEach((el, i) => {
    el.classList.add('reveal');
    /* Stagger siblings in grids */
    const parent = el.parentElement;
    const siblings = [...parent.children].filter(c => c.classList.contains('reveal'));
    const idx = siblings.indexOf(el);
    el.style.transitionDelay = (idx * 80) + 'ms';
  });

  const io = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (e.isIntersecting) {
        e.target.classList.add('visible');
        io.unobserve(e.target);
      }
    });
  }, { threshold: 0.12, rootMargin: '0px 0px -40px 0px' });

  targets.forEach(el => io.observe(el));
})();

/* Hero — stat count-up (home.html only) */
(function() {
  const stats = document.querySelectorAll('.stat-big');
  if (!stats.length) return;
  if (window.matchMedia('(prefers-reduced-motion: reduce)').matches) return;

  const io = new IntersectionObserver((entries) => {
    entries.forEach(e => {
      if (!e.isIntersecting) return;
      const el = e.target;
      const accent = el.querySelector('.accent');
      const raw = el.textContent.replace(/[^0-9]/g, '');
      const target = parseInt(raw, 10);
      if (!target) return;
      const suffix = el.textContent.replace(/[0-9]/g, '').replace('accent', '').trim();
      let start = null;
      const duration = 1200;
      function step(ts) {
        if (!start) start = ts;
        const progress = Math.min((ts - start) / duration, 1);
        const eased = 1 - Math.pow(1 - progress, 3);
        const current = Math.floor(eased * target);
        el.childNodes[0].textContent = current;
        if (progress < 1) requestAnimationFrame(step);
        else el.childNodes[0].textContent = target;
      }
      requestAnimationFrame(step);
      io.unobserve(el);
    });
  }, { threshold: 0.5 });

  stats.forEach(el => io.observe(el));
})();
</script>
```

---

## FIX 4 — HERO SECTION (home.html only)

Add a CSS animation for the hero text column on page load:

```css
/* Hero text — staggered entrance */
@keyframes heroIn {
  from { opacity: 0; transform: translateY(28px); }
  to   { opacity: 1; transform: translateY(0); }
}

.hero-grid > div:first-child > * {
  animation: heroIn 0.7s ease both;
}
.hero-grid > div:first-child > *:nth-child(1) { animation-delay: 0.05s; }
.hero-grid > div:first-child > *:nth-child(2) { animation-delay: 0.15s; }
.hero-grid > div:first-child > *:nth-child(3) { animation-delay: 0.25s; }
.hero-grid > div:first-child > *:nth-child(4) { animation-delay: 0.35s; }

/* Hero map — entrance */
.hero-map {
  animation: heroIn 0.9s 0.2s ease both;
}

/* Map cards — stagger */
.map-card:nth-child(1) { animation: heroIn 0.6s 0.5s ease both; }
.map-card:nth-child(2) { animation: heroIn 0.6s 0.65s ease both; }
.map-card:nth-child(3) { animation: heroIn 0.6s 0.8s ease both; }
```

---

## FIX 5 — BUTTON UPGRADES (all pages)

```css
.btn-cta {
  background: var(--grad-cta);
  color: var(--ink);
  box-shadow: 0 4px 18px rgba(105,235,209,0.30);
  font-weight: 700;
  transition: box-shadow 0.2s, transform 0.15s, filter 0.2s;
}
.btn-cta:hover {
  opacity: 1; /* override the generic opacity hover */
  filter: brightness(1.06);
  box-shadow: 0 8px 32px rgba(105,235,209,0.50);
  transform: translateY(-2px);
}

.btn-dark {
  background: var(--black);
  color: var(--white);
  transition: background 0.2s, transform 0.15s;
}
.btn-dark:hover {
  background: var(--teal-dark);
  opacity: 1;
  transform: translateY(-1px);
}

.btn:active {
  transform: scale(0.97) !important;
}
```

---

## FIX 6 — CARD POLISH (all pages)

```css
.card {
  background: var(--white);
  border: 1px solid var(--rule);
  border-radius: var(--r-lg);
  padding: 28px;
  transition: box-shadow 0.25s, border-color 0.25s, transform 0.2s;
  position: relative;
}
.card::before {
  content: '';
  position: absolute;
  top: 0; bottom: 0; left: 0;
  width: 3px;
  background: var(--teal);
  border-radius: var(--r-lg) 0 0 var(--r-lg);
  transform: scaleY(0);
  transform-origin: bottom;
  transition: transform 0.22s ease;
}
.card:hover {
  box-shadow: 0 6px 28px rgba(0,0,0,0.08);
  border-color: rgba(69,201,191,0.25);
  transform: translateY(-2px);
}
.card:hover::before {
  transform: scaleY(1);
}
```

---

## FIX 7 — TRACKER WIDGET POLISH (home.html, platform.html)

```css
/* Shimmer on tracker header */
@keyframes shimmer {
  0%   { left: -120%; }
  100% { left: 120%; }
}
.tracker-header {
  position: relative;
  overflow: hidden;
}
.tracker-header::after {
  content: '';
  position: absolute;
  top: 0; bottom: 0;
  left: -120%;
  width: 60%;
  background: linear-gradient(90deg, transparent, rgba(255,255,255,0.12), transparent);
  animation: shimmer 4s 2s ease-in-out infinite;
}

/* Active stage pulse */
.stage.now {
  animation: stagePulse 2.5s ease-in-out infinite;
}
@keyframes stagePulse {
  0%, 100% { box-shadow: 0 0 0 0 rgba(69,201,191,0.3); }
  50%       { box-shadow: 0 0 0 6px rgba(69,201,191,0); }
}

/* Feed item hover */
.feed-item {
  transition: background 0.15s, border-color 0.15s;
  cursor: default;
}
.feed-item:hover {
  background: var(--teal-pale);
  border-color: var(--teal-soft);
}
```

---

## FIX 8 — FOOTER POLISH (all pages)

```css
.site-footer {
  background: var(--ink);
  color: rgba(255,255,255,0.6);
  padding: 72px 0 32px;
  position: relative;
}
/* Gradient top border */
.site-footer::before {
  content: '';
  position: absolute;
  top: 0; left: 0; right: 0;
  height: 1px;
  background: linear-gradient(90deg, transparent 0%, var(--teal) 35%, var(--teal-mint) 65%, transparent 100%);
  opacity: 0.4;
}

.footer-grid a {
  font-size: 14px;
  color: rgba(255,255,255,0.65);
  transition: color 0.15s;
}
.footer-grid a:hover { color: var(--teal-mint); }

/* WeCare badge — gold left border */
.wecare-badge {
  border: 1px solid rgba(255,255,255,0.10);
  border-left: 3px solid var(--gold);
  border-radius: 0 var(--r-md) var(--r-md) 0;
  padding: 14px 16px;
  margin-top: 20px;
  background: rgba(193,154,75,0.04);
}

/* Gold dot pulse in footer */
@keyframes goldPulse {
  0%, 100% { box-shadow: 0 0 0 0 rgba(193,154,75,0.5); }
  50%       { box-shadow: 0 0 0 5px rgba(193,154,75,0); }
}
.wecare-badge .dot {
  animation: goldPulse 3s ease-in-out infinite;
}
```

---

## WHAT TO PRESERVE (do not touch)

1. All text content — every word, heading, paragraph
2. All internal links: `href="home.html"`, `href="solutions.html"` etc.
3. The base64 world-map image inside `.hero-map`
4. The tracker widget data (project name, KPIs, feed items, stages)
5. The partner strip content (Diaspora·Conseil, Banque Atlantique, SCI WECARE, etc.)
6. The footer grid structure and all links
7. All aria-label attributes
8. All `@media(max-width:980px)` and `@media(max-width:600px)` rules — only add new mobile rules for the unified navbar
9. The `index.html` overview file — only update the iframes to reflect visual changes
10. The `.sec-head`, `.container`, `.g-2/.g-3/.g-4`, `.row-sb` utility classes

---

## OUTPUT FORMAT

Produce complete upgraded files, one by one. Start with **home.html** since it contains the most complex components. Then produce a **shared-styles.css block** (the full `<style>` content) that can be copy-pasted into each other page replacing their existing `<style>` block.

Then produce each remaining page in order:
solutions.html → journey.html → platform.html → projects.html → partners.html → about.html → contact.html → index.html (update iframe heights if needed)

Each file must be 100% complete — no ellipsis, no "// rest of code unchanged." Every line present.
```

---

## 🇫🇷 CE QUE CE PROMPT FAIT — RÉSUMÉ POUR TOI

**Problème 1 résolu — Double navbar** : Fusionnée en une seule barre de 64px avec audience tabs + nav links + WeCare gold + CTA, tout dans la même ligne. Propre, professionnel, comme Uber, Stripe, ou Linear.

**Problème 2 résolu — Typographie IA** : Inter remplacé par Cormorant Garamond (h1/h2, élégant, africain-premium, pas générique) + DM Sans (tout le reste, moderne et lisible). Les poids passent de 900 à 700 — plus raffiné, moins "AI slap".

**Problème 3 résolu — Zéro animation** : Système de scroll reveal avec IntersectionObserver, entrance staggerée pour chaque card, count-up sur les stats, shimmer sur le tracker, pulsations sur les éléments live.

**Plus** : boutons avec micro-interactions, cards avec left border qui "draw-in" au hover, footer avec gradient top border, WeCare badge gold, gold dot qui pulse.

**Tout le contenu préservé** : les textes, les liens, la carte monde, le tracker widget, les témoignages.
