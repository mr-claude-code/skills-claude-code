# Templates de Saida - Design Analyzer

## design-tokens.md

```markdown
# Design Tokens - [Nome do Site]

> Fonte: [URL] | Analisado em: [data]

## Cores

| Token | HEX | RGB | Uso |
|-------|-----|-----|-----|
| primary | #3B82F6 | rgb(59,130,246) | Botoes, links, CTAs |
| background | #0F172A | rgb(15,23,42) | Fundo principal |
| surface | #1E293B | rgb(30,41,59) | Cards, modais |
| text-primary | #F8FAFC | rgb(248,250,252) | Texto principal |
| text-secondary | #94A3B8 | rgb(148,163,184) | Texto secundario |
| border | #334155 | rgb(51,65,85) | Bordas |
| accent | #10B981 | rgb(16,185,129) | Sucesso, destaque |
| danger | #EF4444 | rgb(239,68,68) | Erros, alertas |

### Gradientes
| Nome | Valor | Uso |
|------|-------|-----|
| hero-gradient | linear-gradient(135deg, #3B82F6 0%, #8B5CF6 100%) | Hero background |

## Tipografia

| Elemento | Font Family | Size | Weight | Line Height | Letter Spacing | Color |
|----------|-------------|------|--------|-------------|----------------|-------|
| H1 | Plus Jakarta Sans | 48px / 3rem | 800 | 1.2 | -0.02em | #F8FAFC |
| H2 | Plus Jakarta Sans | 36px / 2.25rem | 700 | 1.3 | -0.01em | #F8FAFC |
| H3 | Plus Jakarta Sans | 24px / 1.5rem | 600 | 1.4 | 0 | #F8FAFC |
| Body | Inter | 16px / 1rem | 400 | 1.6 | 0 | #CBD5E1 |
| Small | Inter | 14px / 0.875rem | 400 | 1.5 | 0 | #94A3B8 |
| Button | Inter | 14px / 0.875rem | 600 | 1 | 0.025em | #FFFFFF |
| Caption | Inter | 12px / 0.75rem | 500 | 1.4 | 0.05em | #64748B |

## Espacamento

| Contexto | Padding | Margin | Gap |
|----------|---------|--------|-----|
| Page container | 0 24px | 0 auto | - |
| Section | 64px 0 / 4rem 0 | 0 | 32px / 2rem |
| Card | 24px / 1.5rem | 0 | 16px / 1rem |
| Button | 12px 24px | 0 | 8px |
| Navbar | 16px 24px | 0 | 24px |

## Bordas e Sombras

| Elemento | Border Radius | Border | Box Shadow |
|----------|---------------|--------|------------|
| Card | 12px / 0.75rem | 1px solid #334155 | 0 4px 6px -1px rgba(0,0,0,0.1) |
| Button | 8px / 0.5rem | none | none |
| Input | 8px / 0.5rem | 1px solid #475569 | 0 1px 2px rgba(0,0,0,0.05) |
| Modal | 16px / 1rem | none | 0 25px 50px -12px rgba(0,0,0,0.25) |
| Badge | 9999px | none | none |
| Avatar | 9999px | 2px solid #3B82F6 | none |

## Animacoes e Transicoes

| Elemento | Propriedade | Duracao | Easing | Delay |
|----------|-------------|---------|--------|-------|
| Button hover | background-color, transform | 200ms | ease-in-out | 0 |
| Card hover | transform, box-shadow | 300ms | ease | 0 |
| Modal enter | opacity, transform | 200ms | ease-out | 0 |
| Fade in | opacity | 500ms | ease | 0 |

## CSS Custom Properties

```css
:root {
  --color-primary: #3B82F6;
  --color-bg: #0F172A;
  --radius-default: 8px;
  --shadow-card: 0 4px 6px -1px rgba(0,0,0,0.1);
}
```
```

## README.md

```markdown
# Design Analysis - [Nome do Site]

- **URL**: [url]
- **Data da analise**: [data]
- **Tipo**: [Landing page / Dashboard / SaaS / E-commerce]

## Resumo Visual
[Descricao breve do estilo: dark mode, minimalista, glassmorphism, etc.]

## Stack Detectada
- Framework CSS: [Tailwind / Bootstrap / Custom]
- Fontes: [Google Fonts / Self-hosted]
- Icones: [Lucide / Heroicons / FontAwesome]

## Componentes Identificados
- [x] Navbar
- [x] Hero
- [x] Cards
- [ ] Sidebar
- [x] Footer
- [x] CTA Section

## Arquivos
- `design-tokens.md` - Todas as cores, fontes, espacamentos
- `wireframe.md` - Layout grid e dimensoes
- `components/` - Analise por componente
- `screenshots/` - Capturas visuais
- `implementation-guide.md` - Guia de implementacao
```

## Componente (template)

```markdown
# [Nome do Componente]

> Screenshot: `screenshots/[componente].png`

## Layout
- **Display**: flex / grid
- **Dimensoes**: width x height
- **Max Width**: valor
- **Position**: relative / fixed / sticky

## Estilos

```css
.componente {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 24px;
  background-color: #0F172A;
  border-bottom: 1px solid #1E293B;
  max-width: 1280px;
  margin: 0 auto;
}
```

## Tailwind Equivalente
```html
<div class="flex items-center justify-between px-6 py-4 bg-slate-900 border-b border-slate-800 max-w-7xl mx-auto">
```

## Tokens Utilizados
| Token | Valor | Propriedade |
|-------|-------|-------------|
| bg | #0F172A | background-color |
| border | #1E293B | border-color |
| padding | 16px 24px | padding |

## Estados
| Estado | Propriedade | Valor |
|--------|-------------|-------|
| hover | background-color | #1E293B |
| active | opacity | 0.9 |

## Responsividade
| Breakpoint | Mudanca |
|------------|---------|
| < 768px | Hamburger menu, stack vertical |
| < 640px | Logo menor, padding reduzido |
```

## wireframe.md

```markdown
# Wireframe - [Nome do Site]

## Grid System
- **Container**: max-width 1280px, margin 0 auto, padding 0 24px
- **Colunas**: 12 colunas (ou flexbox)
- **Gutter**: 24px

## Breakpoints
| Nome | Valor | Uso |
|------|-------|-----|
| sm | 640px | Mobile landscape |
| md | 768px | Tablet |
| lg | 1024px | Desktop |
| xl | 1280px | Large desktop |

## Layout por Secao

### Navbar (sticky top)
- Height: 64px
- Largura: 100%
- Conteudo: Logo | Nav Links | CTA Button

### Hero
- Height: ~600px
- Padding: 80px 24px
- Layout: 2 colunas (texto 60% | imagem 40%)

### Features/Cards
- Grid: 3 colunas em desktop, 1 em mobile
- Card: 360px x 280px
- Gap: 24px

### Footer
- Height: ~200px
- Grid: 4 colunas
- Padding: 48px 24px
```

## implementation-guide.md

```markdown
# Guia de Implementacao

## Setup Inicial

### Tailwind Config
```js
module.exports = {
  theme: {
    extend: {
      colors: {
        primary: '#3B82F6',
        background: '#0F172A',
        surface: '#1E293B',
      },
      fontFamily: {
        heading: ['Plus Jakarta Sans', 'sans-serif'],
        body: ['Inter', 'sans-serif'],
      },
      borderRadius: {
        card: '12px',
      },
      boxShadow: {
        card: '0 4px 6px -1px rgba(0,0,0,0.1)',
      }
    }
  }
}
```

### Fontes
```html
<link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@600;700;800&family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
```

## Snippets por Componente

### Navbar - Tailwind
```html
<nav class="sticky top-0 z-50 flex items-center justify-between px-6 py-4 bg-slate-900/80 backdrop-blur-md border-b border-slate-800">
  <div class="text-xl font-bold text-white">Logo</div>
  <div class="hidden md:flex items-center gap-6">
    <a href="#" class="text-sm text-slate-300 hover:text-white transition-colors">Link</a>
  </div>
  <button class="px-4 py-2 text-sm font-semibold text-white bg-blue-500 rounded-lg hover:bg-blue-600 transition-colors">CTA</button>
</nav>
```

### Navbar - CSS Puro
```css
.navbar {
  position: sticky;
  top: 0;
  z-index: 50;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 16px 24px;
  background: rgba(15, 23, 42, 0.8);
  backdrop-filter: blur(12px);
  border-bottom: 1px solid #1e293b;
}
```
```
