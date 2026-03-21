# Claude Code Skills Collection

Uma coleção de skills especializadas para estender as capacidades do Claude Code em diversos domínios e workflows.

**Skills no repositório:** 26 skills + 1 referência externa | **Última atualização:** Março 2026

## Skills Disponíveis

### Desenvolvimento

| Skill | Descrição |
|-------|-----------|
| **[fullstack-dev](fullstack-dev/)** | Desenvolvimento fullstack com Clean Architecture, DDD, TDD, segurança e DevOps. Para construir aplicações web completas e prontas para produção. |
| **[software-engineer](software-engineer/)** | Engenheiro de Software Ultra Sênior (15+ anos) com maestria em 8 níveis: de fundamentos de CS e algoritmos até DevOps, segurança, desenvolvimento com IA e liderança técnica. |
| **[software-architecture](software-architecture/)** | Arquiteto de Software Sênior com domínio em DDD, design patterns, cloud, DevOps e segurança. Para decisões técnicas estratégicas, análise de código e design de arquitetura para MVPs, Micro-SaaS e SaaS. |
| **[long-running-agent](long-running-agent/)** | Protocolo para desenvolvimento de projetos complexos em múltiplas sessões. Usa arquitetura Master Agent + SubAgents com arquivos de progresso em `.claude/` para manter contexto entre sessões. |
| **[mobile-responsiveness](mobile-responsiveness/)** | Guia completo para aplicações web responsivas e mobile-first com CSS moderno e Tailwind CSS (2025/2026). Cobre breakpoints, container queries, tipografia fluida, safe areas e navegação mobile. |

### Segurança

| Skill | Descrição |
|-------|-----------|
| **[appsec-elite-auditor](appsec-elite-auditor/)** | Auditor de segurança ofensiva sênior para aplicações web. Cobre autenticação, autorização, injeções, APIs, pagamentos e supply chain, pensando como um hacker ético real. |
| **[ffuf-skill](ffuf-skill/)** | Orientação especializada para fuzzing web com ffuf. Cobre fuzzing autenticado, auto-calibração, descoberta de diretórios ocultos, subdomínios e análise de resultados. |

### Design e UI/UX

| Skill | Descrição |
|-------|-----------|
| **[interface-design](interface-design/)** | Design de interfaces — dashboards, painéis admin, SaaS apps e ferramentas interativas. Focado em craft e consistência. |
| **[design-principles](design-principles/)** | Design system preciso e minimalista inspirado em Linear, Notion e Stripe. Para dashboards e interfaces enterprise com precisão "Jony Ive". |
| **[design-analyzer](design-analyzer/)** | Analisa páginas web via browser MCP e extrai documentação técnica completa de design (cores, tipografia, espaçamento, componentes, wireframe). Engenharia reversa de UI. |
| **[hero-visual-prompt-generator](hero-visual-prompt-generator/)** | Gera prompts premium de imagem e vídeo para seções hero de landing pages. Prompts cinematográficos otimizados para Nano Banana, FreePik AI, Runway ML e Pika Labs. |

### Qualidade e Testes

| Skill | Descrição |
|-------|-----------|
| **[code-quality-check](code-quality-check/)** | Verificação completa de qualidade de código para Node.js/TypeScript. Executa Prettier, ESLint, TypeScript type checking e test runners como checagem pré-deploy. |
| **[playwright-cli](playwright-cli/)** | Automação de browser para testes web, preenchimento de formulários, screenshots e extração de dados usando playwright-cli via linha de comando. |

### Planejamento e Gestão

| Skill | Descrição |
|-------|-----------|
| **[prd-brainstorm](prd-brainstorm/)** | Brainstorming estruturado e interativo em 5 fases para descoberta de produto, gerando um PRD completo como entrada para o `sprint-context-generator`. |
| **[landing-page-prd-architect](landing-page-prd-architect/)** | PRDs técnicos ultra detalhados para landing pages premium. Discovery interativo, pesquisa visual (Dribbble, Awwwards) e documentação completa com wireframes e prompts de imagem. |
| **[sprint-context-generator](sprint-context-generator/)** | Documentação completa de sprint (spec.md, plan.md, tasks.md) com análise de 6 personas. Gera 50-100 tasks granulares com cobertura E2E e TDD. |
| **[project-brain](project-brain/)** | "Segundo cérebro" para Claude Code usando Obsidian como vault de conhecimento. Mapeia arquitetura, rastreia progresso, documenta decisões e persiste contexto entre sessões. |
| **[napkin](napkin/)** | Runbook curado por repositório em `.claude/napkin.md`. Ativa automaticamente em toda sessão para aplicar orientações de alto valor sobre o projeto. |

### Prompt Engineering

| Skill | Descrição |
|-------|-----------|
| **[lisa-prompt-engineering](lisa-prompt-engineering/)** | Prompts e especificações de alta qualidade para o plugin Lisa (loop iterativo para Claude Code). Gera `PROMPT.md`, specs de features e critérios de verificação. |
| **[ralph-prompt-builder](ralph-prompt-builder/)** | Criação de prompts otimizados para o plugin `ralph-loop`. Templates para TDD, features, bugs e projetos greenfield com validação integrada. |

### Conteúdo e Marketing

| Skill | Descrição |
|-------|-----------|
| **[marketing-expert](marketing-expert/)** | Copywriting e gatilhos mentais baseado na metodologia de Gustavo Ferreira. Focado em vender cursos de programação e produtos digitais com Google Ads e Analytics. |
| **[seo-optimizer](seo-optimizer/)** | Otimização SEO abrangente: pesquisa de keywords, SEO técnico (schema markup, sitemaps, canonical tags), Core Web Vitals, meta tags e estratégia de conteúdo. |
| **[youtube-content-generator](youtube-content-generator/)** | Conteúdo completo e otimizado para YouTube (tecnologia, programação, IA). Títulos, descrições, tags com SEO avançado e thumbnails. |
| **[course-content-creator](course-content-creator/)** | Materiais educacionais para cursos de tecnologia (Claude Code, n8n, programação). Cronogramas, resumos, aulas e infográficos com exemplos práticos. |
| **[last30days-skill](last30days-skill/)** | Pesquisa qualquer tópico dos últimos 30 dias no Reddit, X e web. Entrega recomendações baseadas no que a comunidade está discutindo atualmente. |

### Criação de Skills

| Skill | Descrição |
|-------|-----------|
| **[skill-creator](skill-creator/)** | Guia para criar skills eficazes que estendem as capacidades do Claude. Boas práticas de estruturação, workflows e como escrever skills concisas. |

### Referências Externas

| Pasta | Descrição |
|-------|-----------|
| **[vercel-react-best-practices](vercel-react-best-practices/)** | Links para instalar skills oficiais da Vercel com React Best Practices via `npx skills add vercel-labs/agent-skills`. |

---

## Como Usar

### Instalação

```bash
git clone https://github.com/madeinlowcode/skills-claude-code.git
```

As skills podem ser instaladas individualmente copiando a pasta desejada para `.claude/skills/` do seu projeto, ou usadas diretamente pelo Claude Code.

### Estrutura de uma Skill

```
skill-name/
├── SKILL.md              # Arquivo principal (obrigatório)
├── scripts/              # Scripts executáveis (opcional)
├── references/           # Documentação de referência (opcional)
└── assets/               # Arquivos usados na saída (opcional)
```

Cada `SKILL.md` contém um frontmatter YAML com `name` e `description`, seguido das instruções em Markdown.

## Princípios de Design

- **Concisão** — O context window é compartilhado. Apenas adicione contexto que o Claude não possui.
- **Progressive Disclosure** — Metadata sempre em contexto, SKILL.md quando ativado, recursos sob demanda.
- **Graus de Liberdade** — Alta para abordagens múltiplas, baixa para operações frágeis.

## Contribuindo

1. Use o `skill-creator` para guiar o processo
2. Siga os princípios de design documentados
3. Teste a skill em casos de uso reais
4. Envie um Pull Request

## Links Úteis

- [Repositório GitHub](https://github.com/madeinlowcode/skills-claude-code)
- [Claude Code Documentation](https://docs.anthropic.com/claude-code)
- [Anthropic Developer Docs](https://docs.anthropic.com)
