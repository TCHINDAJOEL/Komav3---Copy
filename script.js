/* ═══════════════════════════════════════════════════════════
   KOMA EXPERTISE — Main JS
   ═══════════════════════════════════════════════════════════ */

(function () {
  'use strict';

  /* ─── SCROLL NAV ─── */
  const header = document.getElementById('site-header');
  if (header) {
    const onScroll = () => header.classList.toggle('scrolled', window.scrollY > 60);
    window.addEventListener('scroll', onScroll, { passive: true });
    onScroll();
  }

  /* ─── MOBILE MENU ─── */
  const burgerBtn = document.getElementById('burger-btn');
  const mobileMenu = document.getElementById('mobile-menu');
  if (burgerBtn && mobileMenu) {
    burgerBtn.addEventListener('click', () => {
      const open = mobileMenu.classList.toggle('open');
      burgerBtn.classList.toggle('open', open);
      burgerBtn.setAttribute('aria-expanded', open);
      document.body.style.overflow = open ? 'hidden' : '';
    });
    mobileMenu.querySelectorAll('a').forEach(link => {
      link.addEventListener('click', () => {
        mobileMenu.classList.remove('open');
        burgerBtn.classList.remove('open');
        burgerBtn.setAttribute('aria-expanded', false);
        document.body.style.overflow = '';
      });
    });
  }

  /* ─── REVEAL ON SCROLL ─── */
  if ('IntersectionObserver' in window) {
    const obs = new IntersectionObserver(entries => {
      entries.forEach(e => {
        if (e.isIntersecting) { e.target.classList.add('visible'); obs.unobserve(e.target); }
      });
    }, { threshold: 0.1, rootMargin: '0px 0px -36px 0px' });
    document.querySelectorAll('.reveal').forEach(el => obs.observe(el));
  } else {
    document.querySelectorAll('.reveal').forEach(el => el.classList.add('visible'));
  }

  /* ─── FAQ ACCORDION ─── */
  document.querySelectorAll('.faq-item').forEach(item => {
    const trigger = item.querySelector('.faq-trigger');
    const content = item.querySelector('.faq-body');
    if (!trigger || !content) return;
    trigger.setAttribute('aria-expanded', 'false');
    trigger.addEventListener('click', () => {
      const isOpen = item.classList.contains('open');
      document.querySelectorAll('.faq-item.open').forEach(i => {
        i.classList.remove('open');
        const t = i.querySelector('.faq-trigger');
        const c = i.querySelector('.faq-body');
        if (t) t.setAttribute('aria-expanded', 'false');
        if (c) c.style.maxHeight = null;
      });
      if (!isOpen) {
        item.classList.add('open');
        trigger.setAttribute('aria-expanded', 'true');
        content.style.maxHeight = content.scrollHeight + 'px';
      }
    });
  });

  /* ─── CONTACT FORM — DUAL PATH ─── */
  document.querySelectorAll('[data-path]').forEach(btn => {
    btn.addEventListener('click', () => {
      const path = btn.dataset.path;
      document.querySelectorAll('[data-path]').forEach(b => b.classList.toggle('active', b.dataset.path === path));
      document.querySelectorAll('[data-form]').forEach(f => f.classList.toggle('active', f.dataset.form === path));
    });
  });

  /* ─── PLATFORM TABS ─── */
  document.querySelectorAll('[data-tab]').forEach(btn => {
    btn.addEventListener('click', () => {
      const tab = btn.dataset.tab;
      const group = btn.closest('[data-tabs]');
      if (!group) return;
      group.querySelectorAll('[data-tab]').forEach(b => b.classList.toggle('active', b.dataset.tab === tab));
      document.querySelectorAll('[data-panel]').forEach(p => p.classList.toggle('active', p.dataset.panel === tab));
    });
  });

  /* ─── SITUATION SELECTOR ─── */
  document.querySelectorAll('.sit-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const group = btn.closest('[data-sit-group]');
      if (!group) return;
      const sit = btn.dataset.sit;
      group.querySelectorAll('.sit-btn').forEach(b => {
        b.classList.toggle('active', b.dataset.sit === sit);
      });
      const recommended = btn.dataset.recommend ? btn.dataset.recommend.split(',') : [];
      const cards = document.querySelectorAll('[data-svc]');
      cards.forEach(card => {
        card.classList.remove('svc-dimmed', 'svc-recommended');
        if (recommended.length > 0) {
          if (recommended.includes(card.dataset.svc)) {
            card.classList.add('svc-recommended');
          } else {
            card.classList.add('svc-dimmed');
          }
        }
      });
    });
  });

  /* ─── PAIN ACCORDION "VOIR PLUS" ─── */
  document.querySelectorAll('.pain-more-trigger').forEach(btn => {
    const target = document.querySelector(btn.dataset.target);
    if (!target) return;
    btn.setAttribute('aria-expanded', 'false');
    btn.addEventListener('click', () => {
      const isOpen = target.classList.toggle('open');
      btn.setAttribute('aria-expanded', isOpen);
      target.style.maxHeight = isOpen ? target.scrollHeight + 'px' : '0';
      const label = btn.querySelector('.pain-more-label');
      if (label) label.textContent = isOpen ? 'Réduire' : btn.dataset.labelClosed || 'Voir les autres risques';
      const arrow = btn.querySelector('.arrow');
      if (arrow) arrow.style.transform = isOpen ? 'rotate(180deg)' : '';
    });
  });

  /* ─── STEP ACCORDION (journey) ─── */
  document.querySelectorAll('.step-trigger').forEach(trigger => {
    const item = trigger.closest('.step-item');
    const body = item?.querySelector('.step-body');
    if (!item || !body) return;
    trigger.setAttribute('aria-expanded', 'false');
    trigger.addEventListener('click', () => {
      const isOpen = item.classList.toggle('open');
      trigger.setAttribute('aria-expanded', isOpen);
      body.style.maxHeight = isOpen ? body.scrollHeight + 'px' : null;
    });
  });

  /* ─── PROJECT FILTER ─── */
  document.querySelectorAll('.filter-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const group = btn.closest('[data-tabs]');
      if (!group) return;
      const filter = btn.dataset.tab;
      group.querySelectorAll('.filter-btn').forEach(b => b.classList.toggle('active', b.dataset.tab === filter));
      const cards = document.querySelectorAll('[data-filter]');
      cards.forEach(card => {
        if (filter === 'all' || card.dataset.filter === filter) {
          card.style.display = '';
          card.style.opacity = '1';
        } else {
          card.style.display = 'none';
        }
      });
    });
  });

  /* ─── SMOOTH ANCHORS ─── */
  document.querySelectorAll('a[href^="#"]').forEach(link => {
    link.addEventListener('click', e => {
      const id = link.getAttribute('href');
      const target = document.querySelector(id);
      if (target) { e.preventDefault(); target.scrollIntoView({ behavior: 'smooth', block: 'start' }); }
    });
  });

  /* ─── NUMBER COUNTER ANIMATION ─── */
  function animateCount(el) {
    const target = parseFloat(el.dataset.count);
    const suffix = el.dataset.suffix || '';
    const duration = 1400;
    const start = performance.now();
    const update = (now) => {
      const elapsed = now - start;
      const progress = Math.min(elapsed / duration, 1);
      const ease = 1 - Math.pow(1 - progress, 3);
      el.textContent = (target % 1 === 0)
        ? Math.round(target * ease) + suffix
        : (target * ease).toFixed(1) + suffix;
      if (progress < 1) requestAnimationFrame(update);
    };
    requestAnimationFrame(update);
  }

  if ('IntersectionObserver' in window) {
    const counterObs = new IntersectionObserver(entries => {
      entries.forEach(e => {
        if (e.isIntersecting) { animateCount(e.target); counterObs.unobserve(e.target); }
      });
    }, { threshold: 0.5 });
    document.querySelectorAll('[data-count]').forEach(el => counterObs.observe(el));
  }

})();
