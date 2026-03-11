---
name: design-analyzer
description: Especialista em analise visual e extracao de design de paginas web. Transforma qualquer URL em documentacao tecnica completa de design (cores, tipografia, espacamento, componentes, wireframe) pronta para implementacao. Usar quando o usuario pedir para "analisar design", "extrair design", "copiar estilo", "inspiracao de design", "analisar layout", "extrair paleta de cores", "analisar pagina", ou fornecer uma URL pedindo analise visual. Tambem usar quando precisar replicar o visual de um site existente, fazer engenharia reversa de UI, ou documentar o design system de uma pagina.
---

# Design Analyzer

Analisa paginas web reais via browser MCP e extrai documentacao tecnica completa de design.

## Workflow

### 1. Acessar a pagina via Browser MCP

Usar um dos MCPs de browser disponiveis (prioridade):
1. **Playwright MCP** (`browser_navigate` + `browser_take_screenshot` + `browser_evaluate`)
2. **Claude in Chrome** (`navigate` + `get_page_text` + `javascript_tool`)

```
# Playwright
browser_navigate -> URL
browser_take_screenshot -> full-page screenshot
browser_evaluate -> injetar scripts de extracao

# Claude in Chrome
navigate -> URL
javascript_tool -> injetar scripts de extracao
```

### 2. Capturar screenshots

Salvar em `docs/design-analysis/screenshots/`:
- `full-page.png` - pagina completa
- `navbar.png`, `hero.png`, `footer.png`, etc. - componentes isolados

### 3. Extrair design tokens

Injetar `scripts/extract-styles.js` via browser MCP para extrair automaticamente:
- Cores (com conversao RGB -> HEX)
- Tipografia (font-family, size, weight, line-height, letter-spacing)
- Bordas e sombras
- CSS custom properties (variaveis :root)
- Classes Tailwind detectadas
- Animacoes e transicoes

### 4. Mapear componentes

Injetar `scripts/extract-components.js` para detectar e medir:
- Navbar, sidebar, hero, cards, CTAs, footer, modais, forms, tabelas, badges
- Dimensoes (width, height, position)
- Estilos computados de cada componente
- Breakpoints responsivos detectados nas media queries

### 5. Gerar documentacao

Criar a estrutura em `docs/design-analysis/`:

```
docs/design-analysis/
  README.md
  design-tokens.md
  wireframe.md
  implementation-guide.md
  components/
    navbar.md
    hero.md
    cards.md
    footer.md
    [componente].md
  screenshots/
    full-page.png
    [componente].png
```

Consultar `references/output-templates.md` para formato exato de cada arquivo.

## Regras

- SEMPRE acessar a pagina real via browser MCP. Nunca inventar valores de design
- Extrair valores exatos em px/rem. Nunca usar termos vagos como "espacamento grande"
- Incluir snippets prontos em Tailwind CSS E CSS puro no implementation-guide.md
- Se a pagina usa Tailwind, extrair as classes diretamente do DOM
- Documentar estados (hover, active, focus, disabled) quando detectados
- Registrar breakpoints responsivos observados
- Para animacoes: documentar propriedade, duracao, easing, delay
- Analisar CSS custom properties (:root) e incluir no design-tokens.md

## Extracao via JavaScript

Os scripts em `scripts/` fazem a extracao automatica. Para dados adicionais, injetar JS customizado:

```js
// Extrair computed style de um elemento especifico
JSON.stringify((() => {
  const el = document.querySelector('.seletor');
  const cs = getComputedStyle(el);
  return { bg: cs.backgroundColor, color: cs.color, padding: cs.padding, font: cs.font };
})());
```

```js
// Extrair todas as fontes carregadas
JSON.stringify([...document.fonts].map(f => ({ family: f.family, weight: f.weight, style: f.style, status: f.status })));
```

```js
// Extrair icones (SVGs inline)
document.querySelectorAll('svg').length + ' SVGs encontrados';
```
