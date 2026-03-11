// Script para mapear componentes da pagina e extrair suas dimensoes/estilos
// Injetar via browser MCP no contexto da pagina

(function extractComponents() {
  const componentSelectors = {
    navbar: 'nav, header, [role="navigation"], .navbar, .nav, .header, #header, #navbar',
    sidebar: 'aside, [role="complementary"], .sidebar, #sidebar, .side-nav',
    hero: '.hero, [class*="hero"], section:first-of-type, .banner, [class*="banner"]',
    footer: 'footer, [role="contentinfo"], .footer, #footer',
    cards: '.card, [class*="card"], .tile, [class*="tile"]',
    buttons: 'button, .btn, [class*="btn"], a.button, [role="button"]',
    forms: 'form, .form, [class*="form"]',
    modals: '.modal, [class*="modal"], [role="dialog"], .dialog',
    tables: 'table, .table, [class*="table"]',
    badges: '.badge, [class*="badge"], .tag, .chip',
    tooltips: '[class*="tooltip"], [data-tooltip], [role="tooltip"]'
  };

  const components = {};

  for (const [name, selector] of Object.entries(componentSelectors)) {
    const elements = document.querySelectorAll(selector);
    if (elements.length === 0) continue;

    components[name] = [];
    elements.forEach((el, i) => {
      if (i >= 5) return; // max 5 per type
      const rect = el.getBoundingClientRect();
      const cs = getComputedStyle(el);

      // Extract Tailwind classes
      const classes = el.className?.toString() || '';
      const tailwind = classes.split(/\s+/).filter(c =>
        /^(bg-|text-|p-|px-|py-|m-|mx-|my-|flex|grid|gap-|rounded|shadow|border|w-|h-|max-w|font-|leading-|tracking-|items-|justify-|space-|relative|absolute|fixed|sticky|z-|overflow|opacity|transition|duration|ease|hover:|focus:|dark:)/.test(c)
      );

      components[name].push({
        index: i,
        tag: el.tagName,
        classes: classes.slice(0, 200),
        tailwindClasses: tailwind,
        dimensions: {
          width: Math.round(rect.width),
          height: Math.round(rect.height),
          top: Math.round(rect.top),
          left: Math.round(rect.left)
        },
        styles: {
          display: cs.display,
          position: cs.position,
          backgroundColor: cs.backgroundColor,
          color: cs.color,
          padding: cs.padding,
          margin: cs.margin,
          gap: cs.gap,
          borderRadius: cs.borderRadius,
          boxShadow: cs.boxShadow !== 'none' ? cs.boxShadow : null,
          fontSize: cs.fontSize,
          fontWeight: cs.fontWeight,
          fontFamily: cs.fontFamily,
          maxWidth: cs.maxWidth,
          gridTemplateColumns: cs.gridTemplateColumns !== 'none' ? cs.gridTemplateColumns : null,
          flexDirection: cs.flexDirection,
          alignItems: cs.alignItems,
          justifyContent: cs.justifyContent
        },
        childCount: el.children.length,
        textContent: el.textContent?.trim().slice(0, 100)
      });
    });
  }

  // Detect sections
  const sections = [];
  document.querySelectorAll('section, [class*="section"], main > div').forEach((el, i) => {
    if (i >= 15) return;
    const rect = el.getBoundingClientRect();
    const cs = getComputedStyle(el);
    sections.push({
      index: i,
      tag: el.tagName,
      classes: (el.className?.toString() || '').slice(0, 150),
      dimensions: { width: Math.round(rect.width), height: Math.round(rect.height), top: Math.round(rect.top) },
      styles: {
        backgroundColor: cs.backgroundColor,
        padding: cs.padding,
        maxWidth: cs.maxWidth,
        display: cs.display,
        gap: cs.gap
      }
    });
  });

  // Detect breakpoints from media queries
  const breakpoints = new Set();
  for (const sheet of document.styleSheets) {
    try {
      for (const rule of sheet.cssRules) {
        if (rule instanceof CSSMediaRule) {
          const match = rule.conditionText?.match(/(\d+)px/g);
          if (match) match.forEach(bp => breakpoints.add(bp));
        }
      }
    } catch (e) { /* cross-origin */ }
  }

  return JSON.stringify({
    components,
    sections,
    breakpoints: [...breakpoints].sort((a, b) => parseInt(a) - parseInt(b)),
    pageHeight: document.documentElement.scrollHeight,
    pageWidth: document.documentElement.scrollWidth
  }, null, 2);
})();
