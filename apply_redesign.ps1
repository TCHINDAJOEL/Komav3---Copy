
# KOMA redesign script — applies all CSS/HTML fixes with proper UTF-8 encoding
$utf8 = [System.Text.Encoding]::UTF8
$utf8noBom = New-Object System.Text.UTF8Encoding $false
$dir = "C:\Users\Admin\Downloads\Komav3 - Copy"

$oldFontLink = '<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">'
$newFontLink = '<link href="https://fonts.googleapis.com/css2?family=Rubik:wght@400;500;600;700;900&display=swap" rel="stylesheet">'

$oldFontVars = "--f-display:'Inter',system-ui,sans-serif; --f-body:'Inter',system-ui,sans-serif;"
$newFontVars = "--f-display:'Rubik',system-ui,sans-serif; --f-body:'Rubik',system-ui,sans-serif;"

$oldH = "h1{font-family:var(--f-display);font-size:clamp(40px,6vw,84px);font-weight:900;line-height:1.0;letter-spacing:-0.03em;color:var(--ink);text-wrap:balance;}
h2{font-family:var(--f-display);font-size:clamp(28px,3.8vw,52px);font-weight:800;line-height:1.08;letter-spacing:-0.025em;color:var(--ink);text-wrap:balance;}
h3{font-family:var(--f-display);font-size:clamp(20px,2vw,26px);font-weight:700;line-height:1.15;letter-spacing:-0.015em;color:var(--ink);}
h4{font-family:var(--f-display);font-size:18px;font-weight:700;line-height:1.2;letter-spacing:-0.01em;color:var(--ink);}
p{text-wrap:pretty;}"

$newH = "h1{font-family:var(--f-display);font-size:clamp(44px,6.5vw,88px);font-weight:700;line-height:1.02;letter-spacing:-0.02em;color:var(--ink);text-wrap:balance;}
h2{font-family:var(--f-display);font-size:clamp(30px,4vw,56px);font-weight:700;line-height:1.06;letter-spacing:-0.018em;color:var(--ink);text-wrap:balance;}
h3{font-family:var(--f-body);font-size:clamp(20px,2vw,24px);font-weight:600;line-height:1.2;letter-spacing:-0.01em;color:var(--ink);}
h4{font-family:var(--f-body);font-size:17px;font-weight:600;line-height:1.25;letter-spacing:-0.005em;color:var(--ink);}
blockquote{font-family:var(--f-display);font-weight:600;font-size:clamp(17px,1.6vw,20px);line-height:1.5;font-style:italic;color:var(--ink);}
p{text-wrap:pretty;}"

$oldNavCSS = "/* ===== NAVBAR — UBER STYLE ===== */
.site-header{position:sticky;top:0;z-index:200;background:#111;border-bottom:1px solid rgba(255,255,255,0.08);}
.nav-audience-bar{background:#111;border-bottom:1px solid rgba(255,255,255,0.07);height:46px;}
.nav-audience-bar .container{display:flex;align-items:center;height:100%;}
.nav-brand{display:flex;flex-direction:column;justify-content:center;flex-shrink:0;}
.nav-brand .koma-word{font-family:var(--f-display);font-weight:900;font-size:21px;letter-spacing:0.09em;color:#fff;line-height:1;}
.nav-brand .koma-sub{font-size:8px;font-weight:500;letter-spacing:0.30em;color:rgba(255,255,255,0.45);text-transform:uppercase;margin-top:2px;}
.audience-tabs{display:flex;align-items:center;height:100%;margin-left:36px;}
.aud-tab{height:100%;display:flex;align-items:center;padding:0 20px;font-size:13px;font-weight:600;color:rgba(255,255,255,0.55);border-bottom:2px solid transparent;transition:.15s;white-space:nowrap;}
.aud-tab:hover{color:rgba(255,255,255,0.85);}
.aud-tab.active{color:#fff;border-bottom-color:var(--teal);}
.nav-audience-bar .nav-right{display:flex;align-items:center;gap:10px;margin-left:auto;}
.nav-wecare{font-size:12px;font-weight:600;color:rgba(255,255,255,0.65);background:rgba(255,255,255,0.07);border:1px solid rgba(255,255,255,0.15);padding:5px 12px;border-radius:var(--r-pill);transition:.15s;}
.nav-wecare:hover{background:rgba(255,255,255,0.12);color:#fff;}
.lang-toggle{display:flex;border:1px solid rgba(255,255,255,0.2);border-radius:var(--r-pill);overflow:hidden;}
.lang-toggle button{padding:5px 9px;font-size:11px;font-weight:600;color:rgba(255,255,255,0.55);letter-spacing:0.06em;}
.lang-toggle button.on{background:rgba(255,255,255,0.18);color:#fff;}
.nav-main-bar{background:#1A1A1A;height:54px;border-bottom:1px solid rgba(255,255,255,0.06);}
.nav-main-bar .nav{display:flex;align-items:center;height:100%;}
.nav-links{display:flex;align-items:center;flex:1;height:100%;}
.nav-item{height:100%;display:flex;align-items:center;padding:0 18px;font-size:14px;font-weight:500;color:rgba(255,255,255,0.70);white-space:nowrap;transition:color .15s;position:relative;}
.nav-item:hover,.nav-item.active{color:#fff;}
.nav-item.active::after{content:'';position:absolute;bottom:0;left:18px;right:18px;height:2px;background:var(--teal);border-radius:2px 2px 0 0;}
.nav-item.has-mega{position:relative;}
.nav-item.has-mega>a{color:rgba(255,255,255,0.70);font-size:14px;font-weight:500;display:flex;align-items:center;gap:4px;height:100%;transition:color .15s;}
.nav-item.has-mega:hover>a{color:#fff;}
.chevron{font-size:16px;color:rgba(255,255,255,0.4);transition:transform .2s;display:inline-block;}
.nav-item.has-mega:hover .chevron{transform:rotate(90deg);}
.mega-panel{display:none;position:absolute;top:100%;left:-16px;background:#1E1E1E;border:1px solid rgba(255,255,255,0.10);border-radius:0 0 16px 16px;padding:16px;min-width:520px;box-shadow:0 16px 48px rgba(0,0,0,0.4);z-index:300;}
.nav-item.has-mega:hover .mega-panel{display:block;}
.mega-grid{display:grid;grid-template-columns:1fr 1fr;gap:4px;}
.mega-link{display:flex;align-items:flex-start;gap:12px;padding:12px 14px;border-radius:10px;transition:background .15s;}
.mega-link:hover{background:rgba(255,255,255,0.06);}
.mega-icon{width:36px;height:36px;border-radius:8px;background:rgba(69,201,191,0.14);display:grid;place-items:center;font-size:18px;flex-shrink:0;}
.mega-link strong{display:block;font-size:13px;font-weight:600;color:#fff;margin-bottom:2px;}
.mega-link span{display:block;font-size:12px;color:rgba(255,255,255,0.50);line-height:1.3;}
.nav-ctas{display:flex;align-items:center;gap:8px;flex-shrink:0;padding-left:16px;}
.btn-outline-dark{background:transparent;color:rgba(255,255,255,0.80);border:1.5px solid rgba(255,255,255,0.25);transition:.15s;}
.btn-outline-dark:hover{border-color:rgba(255,255,255,0.5);color:#fff;}"

$newNavCSS = "/* ===== NAVBAR — UNIFIED 64px ===== */
.site-header{position:sticky;top:0;z-index:200;background:#0F0F0F;border-bottom:1px solid rgba(255,255,255,0.07);backdrop-filter:blur(12px);}
.nav-unified{height:64px;display:flex;align-items:center;width:100%;max-width:var(--maxw);margin:0 auto;padding:0 var(--gut);}
.nav-brand{display:flex;flex-direction:column;justify-content:center;flex-shrink:0;}
.nav-brand .koma-word{font-family:var(--f-body);font-weight:700;font-size:18px;letter-spacing:0.14em;color:#fff;line-height:1;}
.nav-brand .koma-sub{font-size:7px;font-weight:500;letter-spacing:0.35em;color:rgba(255,255,255,0.4);text-transform:uppercase;margin-top:3px;}
.nav-divider{width:1px;height:20px;background:rgba(255,255,255,0.12);margin:0 20px;flex-shrink:0;}
.aud-tabs{display:flex;height:100%;margin-right:20px;}
.aud-tab{height:100%;display:flex;align-items:center;padding:0 14px;font-size:12px;font-weight:600;letter-spacing:0.04em;color:rgba(255,255,255,0.45);border-bottom:2px solid transparent;transition:color 0.15s,border-color 0.15s;white-space:nowrap;}
.aud-tab.active{color:#fff;border-bottom-color:var(--teal);}
.aud-tab:hover{color:rgba(255,255,255,0.8);}
.nav-links{display:flex;align-items:center;height:100%;flex:1;}
.nav-item{height:100%;display:flex;align-items:center;padding:0 14px;font-size:13px;font-weight:500;color:rgba(255,255,255,0.60);white-space:nowrap;transition:color 0.15s;position:relative;}
.nav-item::after{content:'';position:absolute;bottom:0;left:14px;right:14px;height:2px;background:var(--teal);border-radius:2px 2px 0 0;transform:scaleX(0);transform-origin:left;transition:transform 0.2s ease;}
.nav-item:hover{color:#fff;}
.nav-item:hover::after,.nav-item.active::after{transform:scaleX(1);}
.nav-item.active{color:#fff;}
.nav-right{display:flex;align-items:center;gap:8px;flex-shrink:0;padding-left:16px;}
.nav-wecare{font-size:11px;font-weight:600;color:var(--gold-soft);background:rgba(193,154,75,0.08);border:1px solid rgba(193,154,75,0.25);padding:5px 12px;border-radius:var(--r-pill);transition:0.15s;letter-spacing:0.04em;}
.nav-wecare:hover{background:rgba(193,154,75,0.16);color:var(--gold);}
.nav-mob{display:none;align-items:center;gap:12px;margin-left:auto;}
.hamburger{width:36px;height:36px;display:flex;flex-direction:column;justify-content:center;gap:5px;cursor:pointer;}
.hamburger span{display:block;width:22px;height:2px;background:rgba(255,255,255,0.8);border-radius:2px;}
.btn-outline-dark{background:transparent;color:rgba(255,255,255,0.80);border:1.5px solid rgba(255,255,255,0.25);transition:.15s;}
.btn-outline-dark:hover{border-color:rgba(255,255,255,0.5);color:#fff;}"

$oldBtnCSS = ".btn{display:inline-flex;align-items:center;gap:8px;padding:13px 22px;border-radius:var(--r-pill);font-family:var(--f-display);font-weight:600;font-size:15px;border:none;cursor:pointer;transition:opacity .15s,transform .15s;white-space:nowrap;}
.btn:hover{opacity:0.92;transform:translateY(-1px);}
.btn-cta{background:var(--grad-cta);color:var(--ink);box-shadow:0 4px 18px rgba(105,235,209,0.35);font-weight:700;}
.btn-dark{background:var(--black);color:var(--white);}
.btn-outline{background:transparent;color:var(--ink);border:2px solid var(--rule);}
.btn-outline-white{background:transparent;color:var(--white);border:2px solid rgba(255,255,255,0.4);}
.btn-white{background:var(--white);color:var(--ink);font-weight:700;}
.btn-sm{padding:9px 16px;font-size:13px;}
.btn .arrow{font-size:15px;transition:transform .2s;}
.btn:hover .arrow{transform:translateX(3px);}"

$newBtnCSS = ".btn{display:inline-flex;align-items:center;gap:8px;padding:13px 22px;border-radius:var(--r-pill);font-family:var(--f-body);font-weight:600;font-size:15px;border:none;cursor:pointer;transition:opacity .15s,transform .15s;white-space:nowrap;}
.btn:hover{opacity:0.92;transform:translateY(-1px);}
.btn-cta{background:var(--grad-cta);color:var(--ink);box-shadow:0 4px 18px rgba(105,235,209,0.30);font-weight:700;transition:box-shadow 0.2s,transform 0.15s,filter 0.2s;}
.btn-cta:hover{opacity:1;filter:brightness(1.06);box-shadow:0 8px 32px rgba(105,235,209,0.50);transform:translateY(-2px);}
.btn-dark{background:var(--black);color:var(--white);transition:background 0.2s,transform 0.15s;}
.btn-dark:hover{background:var(--teal-dark);opacity:1;transform:translateY(-1px);}
.btn-outline{background:transparent;color:var(--ink);border:2px solid var(--rule);}
.btn-outline-white{background:transparent;color:var(--white);border:2px solid rgba(255,255,255,0.4);}
.btn-white{background:var(--white);color:var(--ink);font-weight:700;}
.btn-sm{padding:9px 16px;font-size:13px;}
.btn .arrow{font-size:15px;transition:transform .2s;}
.btn:hover .arrow{transform:translateX(3px);}
.btn:active{transform:scale(0.97) !important;}"

$oldCardCSS = ".card{background:var(--white);border:1px solid var(--rule);border-radius:var(--r-lg);padding:28px;transition:box-shadow .2s,transform .2s;}
.card:hover{box-shadow:0 4px 24px rgba(0,0,0,0.07);}
.card-teal{background:var(--teal-pale);border-color:var(--teal-soft);}
.card-dark{background:var(--ink);border-color:rgba(255,255,255,0.08);color:var(--white);}
.card-dark h3,.card-dark h4{color:var(--white);}
.step-num{font-family:var(--f-display);font-weight:900;font-size:48px;line-height:1;letter-spacing:-0.04em;background:var(--grad-cta);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}
.stat-big{font-family:var(--f-display);font-weight:900;font-size:clamp(36px,4vw,56px);letter-spacing:-0.03em;line-height:1;color:var(--ink);}
.stat-big .accent{background:var(--grad-cta);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}"

$newCardCSS = ".card{background:var(--white);border:1px solid var(--rule);border-radius:var(--r-lg);padding:28px;transition:box-shadow .25s,border-color .25s,transform .2s;position:relative;overflow:hidden;}
.card::before{content:'';position:absolute;top:0;bottom:0;left:0;width:3px;background:var(--teal);border-radius:var(--r-lg) 0 0 var(--r-lg);transform:scaleY(0);transform-origin:bottom;transition:transform 0.22s ease;}
.card:hover{box-shadow:0 6px 28px rgba(0,0,0,0.08);border-color:rgba(69,201,191,0.25);transform:translateY(-2px);}
.card:hover::before{transform:scaleY(1);}
.card-teal{background:var(--teal-pale);border-color:var(--teal-soft);}
.card-dark{background:var(--ink);border-color:rgba(255,255,255,0.08);color:var(--white);}
.card-dark h3,.card-dark h4{color:var(--white);}
.step-num{font-family:var(--f-display);font-weight:900;font-size:42px;line-height:1;letter-spacing:-0.04em;background:var(--grad-cta);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}
.stat-big{font-family:var(--f-display);font-weight:900;font-size:clamp(36px,4vw,56px);letter-spacing:-0.03em;line-height:1;color:var(--ink);}
.stat-big .accent{background:var(--grad-cta);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text;}"

$oldFooterCSS = ".site-footer{background:var(--ink);color:rgba(255,255,255,0.6);padding:72px 0 32px;}
.footer-grid{display:grid;grid-template-columns:1.5fr 1fr 1fr 1fr;gap:48px;padding-bottom:56px;border-bottom:1px solid rgba(255,255,255,0.08);margin-bottom:32px;}
.footer-grid h5{font-size:11px;font-weight:700;letter-spacing:0.16em;text-transform:uppercase;color:rgba(255,255,255,0.45);margin-bottom:16px;}
.footer-grid ul{display:grid;gap:10px;}
.footer-grid a{font-size:14px;color:rgba(255,255,255,0.75);transition:color .15s;}
.footer-grid a:hover{color:#fff;}
.foot-bottom{display:flex;justify-content:space-between;align-items:center;font-size:12px;font-weight:500;letter-spacing:0.06em;color:rgba(255,255,255,0.35);flex-wrap:wrap;gap:12px;}
.foot-bottom a{color:rgba(255,255,255,0.5);}
.foot-bottom a:hover{color:#fff;}
.wecare-badge{border:1px solid rgba(255,255,255,0.12);border-radius:var(--r-md);padding:14px 16px;margin-top:20px;background:rgba(255,255,255,0.03);}
.wecare-badge .wrow{display:flex;align-items:center;gap:8px;font-size:12px;font-weight:600;color:rgba(255,255,255,0.55);letter-spacing:0.1em;text-transform:uppercase;}
.wecare-badge .dot{width:6px;height:6px;border-radius:50%;background:var(--gold);}"

$newFooterCSS = ".site-footer{background:var(--ink);color:rgba(255,255,255,0.6);padding:72px 0 32px;position:relative;}
.site-footer::before{content:'';position:absolute;top:0;left:0;right:0;height:1px;background:linear-gradient(90deg,transparent 0%,var(--teal) 35%,var(--teal-mint) 65%,transparent 100%);opacity:0.4;}
.footer-grid{display:grid;grid-template-columns:1.5fr 1fr 1fr 1fr;gap:48px;padding-bottom:56px;border-bottom:1px solid rgba(255,255,255,0.08);margin-bottom:32px;}
.footer-grid h5{font-size:11px;font-weight:700;letter-spacing:0.16em;text-transform:uppercase;color:rgba(255,255,255,0.45);margin-bottom:16px;}
.footer-grid ul{display:grid;gap:10px;}
.footer-grid a{font-size:14px;color:rgba(255,255,255,0.65);transition:color .15s;}
.footer-grid a:hover{color:var(--teal-mint);}
.foot-bottom{display:flex;justify-content:space-between;align-items:center;font-size:12px;font-weight:500;letter-spacing:0.06em;color:rgba(255,255,255,0.35);flex-wrap:wrap;gap:12px;}
.foot-bottom a{color:rgba(255,255,255,0.5);}
.foot-bottom a:hover{color:#fff;}
.wecare-badge{border:1px solid rgba(255,255,255,0.10);border-left:3px solid var(--gold);border-radius:0 var(--r-md) var(--r-md) 0;padding:14px 16px;margin-top:20px;background:rgba(193,154,75,0.04);}
.wecare-badge .wrow{display:flex;align-items:center;gap:8px;font-size:12px;font-weight:600;color:rgba(255,255,255,0.55);letter-spacing:0.1em;text-transform:uppercase;}
@keyframes goldPulse{0%,100%{box-shadow:0 0 0 0 rgba(193,154,75,0.5);}50%{box-shadow:0 0 0 5px rgba(193,154,75,0);}}
.wecare-badge .dot{width:6px;height:6px;border-radius:50%;background:var(--gold);animation:goldPulse 3s ease-in-out infinite;}"

$oldResponsive = "  .nav-main-bar{display:none;}
  .audience-tabs{display:none;}
  .nav-audience-bar{height:60px;}"
$newResponsive = "  .aud-tabs,.nav-links,.nav-right{display:none;}
  .nav-mob{display:flex;}"

$scrollJS = @'
<script>
(function(){
  if(window.matchMedia('(prefers-reduced-motion:reduce)').matches)return;
  var s=document.createElement('style');
  s.textContent='.reveal{opacity:0;transform:translateY(22px);transition:opacity 0.65s ease,transform 0.65s ease;}.reveal.visible{opacity:1;transform:translateY(0);}';
  document.head.appendChild(s);
  var els=document.querySelectorAll('.card,.sec-head,.tracker,figure,.imgph,.kpi,.stage,.feed-item,.wecare-section .lead,.wecare-section h2,.step-num,.stat-big');
  els.forEach(function(el){
    el.classList.add('reveal');
    var p=el.parentElement,sibs=[].slice.call(p.children).filter(function(c){return c.classList.contains('reveal');});
    el.style.transitionDelay=(sibs.indexOf(el)*80)+'ms';
  });
  var io=new IntersectionObserver(function(entries){
    entries.forEach(function(e){if(e.isIntersecting){e.target.classList.add('visible');io.unobserve(e.target);}});
  },{threshold:0.12,rootMargin:'0px 0px -40px 0px'});
  els.forEach(function(el){io.observe(el);});
})();
</script>
'@

# Navbars per page — clients side (home, solutions, journey, platform, projects, about, contact)
# professionals side (partners)
$navbars = @{
  "solutions.html" = @'
<header class="site-header" id="site-header">
  <nav class="nav-unified" aria-label="Navigation principale">
    <a href="home.html" class="nav-brand" aria-label="KOMA accueil">
      <div class="koma-word">KOMA</div>
      <div class="koma-sub">Expertise</div>
    </a>
    <div class="nav-divider"></div>
    <div class="aud-tabs">
      <a href="home.html" class="aud-tab active">Pour les clients</a>
      <a href="partners.html" class="aud-tab">Pour les professionnels</a>
    </div>
    <div class="nav-links">
      <a href="solutions.html" class="nav-item active">Solutions</a>
      <a href="journey.html" class="nav-item">Comment ca marche</a>
      <a href="platform.html" class="nav-item">Plateforme</a>
      <a href="projects.html" class="nav-item">Projets</a>
      <a href="about.html" class="nav-item">A propos</a>
    </div>
    <div class="nav-right">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <a href="contact.html" class="btn btn-cta btn-sm">Estimer mon projet</a>
    </div>
    <div class="nav-mob">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <button class="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
    </div>
  </nav>
</header>
'@
  "journey.html" = @'
<header class="site-header" id="site-header">
  <nav class="nav-unified" aria-label="Navigation principale">
    <a href="home.html" class="nav-brand" aria-label="KOMA accueil">
      <div class="koma-word">KOMA</div>
      <div class="koma-sub">Expertise</div>
    </a>
    <div class="nav-divider"></div>
    <div class="aud-tabs">
      <a href="home.html" class="aud-tab active">Pour les clients</a>
      <a href="partners.html" class="aud-tab">Pour les professionnels</a>
    </div>
    <div class="nav-links">
      <a href="solutions.html" class="nav-item">Solutions</a>
      <a href="journey.html" class="nav-item active">Comment ca marche</a>
      <a href="platform.html" class="nav-item">Plateforme</a>
      <a href="projects.html" class="nav-item">Projets</a>
      <a href="about.html" class="nav-item">A propos</a>
    </div>
    <div class="nav-right">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <a href="contact.html" class="btn btn-cta btn-sm">Estimer mon projet</a>
    </div>
    <div class="nav-mob">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <button class="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
    </div>
  </nav>
</header>
'@
  "platform.html" = @'
<header class="site-header" id="site-header">
  <nav class="nav-unified" aria-label="Navigation principale">
    <a href="home.html" class="nav-brand" aria-label="KOMA accueil">
      <div class="koma-word">KOMA</div>
      <div class="koma-sub">Expertise</div>
    </a>
    <div class="nav-divider"></div>
    <div class="aud-tabs">
      <a href="home.html" class="aud-tab active">Pour les clients</a>
      <a href="partners.html" class="aud-tab">Pour les professionnels</a>
    </div>
    <div class="nav-links">
      <a href="solutions.html" class="nav-item">Solutions</a>
      <a href="journey.html" class="nav-item">Comment ca marche</a>
      <a href="platform.html" class="nav-item active">Plateforme</a>
      <a href="projects.html" class="nav-item">Projets</a>
      <a href="about.html" class="nav-item">A propos</a>
    </div>
    <div class="nav-right">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <a href="contact.html" class="btn btn-cta btn-sm">Estimer mon projet</a>
    </div>
    <div class="nav-mob">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <button class="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
    </div>
  </nav>
</header>
'@
  "projects.html" = @'
<header class="site-header" id="site-header">
  <nav class="nav-unified" aria-label="Navigation principale">
    <a href="home.html" class="nav-brand" aria-label="KOMA accueil">
      <div class="koma-word">KOMA</div>
      <div class="koma-sub">Expertise</div>
    </a>
    <div class="nav-divider"></div>
    <div class="aud-tabs">
      <a href="home.html" class="aud-tab active">Pour les clients</a>
      <a href="partners.html" class="aud-tab">Pour les professionnels</a>
    </div>
    <div class="nav-links">
      <a href="solutions.html" class="nav-item">Solutions</a>
      <a href="journey.html" class="nav-item">Comment ca marche</a>
      <a href="platform.html" class="nav-item">Plateforme</a>
      <a href="projects.html" class="nav-item active">Projets</a>
      <a href="about.html" class="nav-item">A propos</a>
    </div>
    <div class="nav-right">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <a href="contact.html" class="btn btn-cta btn-sm">Estimer mon projet</a>
    </div>
    <div class="nav-mob">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <button class="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
    </div>
  </nav>
</header>
'@
  "partners.html" = @'
<header class="site-header" id="site-header">
  <nav class="nav-unified" aria-label="Navigation principale">
    <a href="home.html" class="nav-brand" aria-label="KOMA accueil">
      <div class="koma-word">KOMA</div>
      <div class="koma-sub">Expertise</div>
    </a>
    <div class="nav-divider"></div>
    <div class="aud-tabs">
      <a href="home.html" class="aud-tab">Pour les clients</a>
      <a href="partners.html" class="aud-tab active">Pour les professionnels</a>
    </div>
    <div class="nav-links">
      <a href="solutions.html" class="nav-item">Solutions</a>
      <a href="journey.html" class="nav-item">Comment ca marche</a>
      <a href="platform.html" class="nav-item">Plateforme</a>
      <a href="projects.html" class="nav-item">Projets</a>
      <a href="about.html" class="nav-item">A propos</a>
    </div>
    <div class="nav-right">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <a href="contact.html" class="btn btn-cta btn-sm">Estimer mon projet</a>
    </div>
    <div class="nav-mob">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <button class="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
    </div>
  </nav>
</header>
'@
  "about.html" = @'
<header class="site-header" id="site-header">
  <nav class="nav-unified" aria-label="Navigation principale">
    <a href="home.html" class="nav-brand" aria-label="KOMA accueil">
      <div class="koma-word">KOMA</div>
      <div class="koma-sub">Expertise</div>
    </a>
    <div class="nav-divider"></div>
    <div class="aud-tabs">
      <a href="home.html" class="aud-tab active">Pour les clients</a>
      <a href="partners.html" class="aud-tab">Pour les professionnels</a>
    </div>
    <div class="nav-links">
      <a href="solutions.html" class="nav-item">Solutions</a>
      <a href="journey.html" class="nav-item">Comment ca marche</a>
      <a href="platform.html" class="nav-item">Plateforme</a>
      <a href="projects.html" class="nav-item">Projets</a>
      <a href="about.html" class="nav-item active">A propos</a>
    </div>
    <div class="nav-right">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <a href="contact.html" class="btn btn-cta btn-sm">Estimer mon projet</a>
    </div>
    <div class="nav-mob">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <button class="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
    </div>
  </nav>
</header>
'@
  "contact.html" = @'
<header class="site-header" id="site-header">
  <nav class="nav-unified" aria-label="Navigation principale">
    <a href="home.html" class="nav-brand" aria-label="KOMA accueil">
      <div class="koma-word">KOMA</div>
      <div class="koma-sub">Expertise</div>
    </a>
    <div class="nav-divider"></div>
    <div class="aud-tabs">
      <a href="home.html" class="aud-tab active">Pour les clients</a>
      <a href="partners.html" class="aud-tab">Pour les professionnels</a>
    </div>
    <div class="nav-links">
      <a href="solutions.html" class="nav-item">Solutions</a>
      <a href="journey.html" class="nav-item">Comment ca marche</a>
      <a href="platform.html" class="nav-item">Plateforme</a>
      <a href="projects.html" class="nav-item">Projets</a>
      <a href="about.html" class="nav-item">A propos</a>
    </div>
    <div class="nav-right">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <a href="contact.html" class="btn btn-cta btn-sm">Estimer mon projet</a>
    </div>
    <div class="nav-mob">
      <a href="partners.html#wecare" class="nav-wecare">SCI WeCare</a>
      <button class="hamburger" aria-label="Menu"><span></span><span></span><span></span></button>
    </div>
  </nav>
</header>
'@
}

$files = @("solutions.html","journey.html","platform.html","projects.html","partners.html","about.html","contact.html")

foreach ($fname in $files) {
    $fpath = Join-Path $dir $fname
    $c = [System.IO.File]::ReadAllText($fpath, $utf8)
    $c = $c.Replace("`r`n", "`n").Replace("`r", "`n")

    # Font link
    $c = $c.Replace($oldFontLink, $newFontLink)
    # CSS vars
    $c = $c.Replace($oldFontVars, $newFontVars)
    # h1-h4 + blockquote
    $c = $c.Replace($oldH, $newH)
    # Nav CSS
    $c = $c.Replace($oldNavCSS, $newNavCSS)
    # Buttons
    $c = $c.Replace($oldBtnCSS, $newBtnCSS)
    # Cards
    $c = $c.Replace($oldCardCSS, $newCardCSS)
    # Footer
    $c = $c.Replace($oldFooterCSS, $newFooterCSS)
    # Responsive
    $c = $c.Replace($oldResponsive, $newResponsive)

    # Replace navbar HTML — find <header...> block
    # Use regex to find and replace the full header block
    $headerPattern = '(?s)<header class="site-header" id="site-header">.*?</header>'
    $newHeader = $navbars[$fname].Trim()
    $c = [regex]::Replace($c, $headerPattern, $newHeader)

    # Add scroll JS before </body>
    $c = $c.Replace("</body>`n</html>", $scrollJS.Trim() + "`n</body>`n</html>")
    $c = $c.Replace("</body>
</html>", $scrollJS.Trim() + "
</body>
</html>")

    [System.IO.File]::WriteAllText($fpath, $c, $utf8noBom)
    Write-Host "Done: $fname"
}

Write-Host "`nAll files updated."
