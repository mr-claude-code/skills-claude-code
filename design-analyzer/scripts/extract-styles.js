// Script para injetar na pagina via browser MCP e extrair computed styles
// Uso: executar via javascript_tool ou browser_evaluate no contexto da pagina

(function extractDesignTokens() {
  const results = { colors: new Set(), fonts: new Set(), spacing: [], borders: [], shadows: [], animations: [] };

  const allElements = document.querySelectorAll('body *');
  const colorProps = ['color', 'backgroundColor', 'borderColor', 'outlineColor'];
  const spacingProps = ['padding', 'margin', 'gap', 'paddingTop', 'paddingRight', 'paddingBottom', 'paddingLeft', 'marginTop', 'marginRight', 'marginBottom', 'marginLeft'];

  const colorMap = {};
  const fontMap = {};

  allElements.forEach(el => {
    const cs = window.getComputedStyle(el);

    // Colors
    colorProps.forEach(prop => {
      const val = cs[prop];
      if (val && val !== 'rgba(0, 0, 0, 0)' && val !== 'transparent') {
        results.colors.add(val);
        if (!colorMap[val]) colorMap[val] = [];
        colorMap[val].push({ tag: el.tagName, class: el.className?.toString().slice(0, 60), prop });
      }
    });

    // Box shadows
    const shadow = cs.boxShadow;
    if (shadow && shadow !== 'none') results.shadows.add ? results.shadows.push(shadow) : null;

    // Fonts
    const fontKey = `${cs.fontFamily}|${cs.fontSize}|${cs.fontWeight}|${cs.lineHeight}|${cs.letterSpacing}`;
    if (!fontMap[fontKey]) {
      fontMap[fontKey] = {
        family: cs.fontFamily,
        size: cs.fontSize,
        weight: cs.fontWeight,
        lineHeight: cs.lineHeight,
        letterSpacing: cs.letterSpacing,
        color: cs.color,
        tag: el.tagName
      };
    }

    // Border radius
    const br = cs.borderRadius;
    if (br && br !== '0px') {
      results.borders.push({ radius: br, tag: el.tagName, class: el.className?.toString().slice(0, 40) });
    }

    // Transitions/Animations
    const transition = cs.transition;
    const animation = cs.animationName;
    if (transition && transition !== 'all 0s ease 0s' && transition !== 'none') {
      results.animations.push({ type: 'transition', value: transition, tag: el.tagName });
    }
    if (animation && animation !== 'none') {
      results.animations.push({ type: 'animation', value: animation, duration: cs.animationDuration, easing: cs.animationTimingFunction });
    }
  });

  // CSS custom properties
  const rootStyles = getComputedStyle(document.documentElement);
  const cssVars = {};
  for (const sheet of document.styleSheets) {
    try {
      for (const rule of sheet.cssRules) {
        if (rule.selectorText === ':root' || rule.selectorText === ':root, :host') {
          for (let i = 0; i < rule.style.length; i++) {
            const prop = rule.style[i];
            if (prop.startsWith('--')) {
              cssVars[prop] = rule.style.getPropertyValue(prop).trim();
            }
          }
        }
      }
    } catch (e) { /* cross-origin */ }
  }

  // Tailwind classes detection
  const tailwindClasses = new Set();
  allElements.forEach(el => {
    if (el.className && typeof el.className === 'string') {
      el.className.split(/\s+/).forEach(cls => {
        if (/^(bg-|text-|p-|px-|py-|m-|mx-|my-|flex|grid|gap-|rounded|shadow|border|w-|h-|max-w|font-|leading-|tracking-)/.test(cls)) {
          tailwindClasses.add(cls);
        }
      });
    }
  });

  // Convert colors to HEX
  function rgbToHex(rgb) {
    const match = rgb.match(/rgba?\((\d+),\s*(\d+),\s*(\d+)/);
    if (!match) return rgb;
    return '#' + [match[1], match[2], match[3]].map(x => parseInt(x).toString(16).padStart(2, '0')).join('');
  }

  const uniqueColors = [...results.colors].map(c => ({ rgb: c, hex: rgbToHex(c), usage: colorMap[c]?.slice(0, 3) }));
  const uniqueFonts = Object.values(fontMap);
  const uniqueShadows = [...new Set(results.shadows)];
  const uniqueBorders = [...new Map(results.borders.map(b => [b.radius, b])).values()];
  const uniqueAnimations = results.animations.slice(0, 20);

  return JSON.stringify({
    colors: uniqueColors,
    fonts: uniqueFonts,
    shadows: uniqueShadows,
    borders: uniqueBorders,
    animations: uniqueAnimations,
    cssVariables: cssVars,
    tailwindClasses: [...tailwindClasses],
    meta: {
      title: document.title,
      url: window.location.href,
      viewport: document.querySelector('meta[name="viewport"]')?.content || 'not set'
    }
  }, null, 2);
})();
