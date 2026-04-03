---
name: anti-vibe-coding
description: "Anti-Vibe Coding methodology for building software projects with AI in a disciplined, spec-driven way. Use this skill ALWAYS when the user wants to create a new project, start a SaaS, MVP, system, web application, API, or any software from scratch. Also use for adding major features to existing projects (brownfield). Trigger when the user mentions: 'new project', 'create system', 'start project', 'build application', 'build SaaS', 'make MVP', 'start development', 'plan project', 'architect system', 'project foundation', 'anti-vibe', 'disciplined coding', 'spec-driven', 'project from zero', 'scaffold project', 'bootstrap project', 'plan before coding', 'structured development', 'TDD project', 'build from scratch', 'add feature properly', 'plan this feature'. This skill enforces 7 sequential phases (onboarding, isolation, foundation with SDD artifacts, specs with Given/When/Then, TDD, implementation, optimization, deploy) — supports both greenfield and brownfield projects. Discipline over Intuition."
---

# Anti-Vibe Coding

> "The developer delivers the skeleton, the AI fills in the organs."
> "Discipline beats intuition. TDD is MORE important WITH AI, not less."

This skill implements the Anti-Vibe Coding methodology for building projects with AI in a disciplined way. It guides the developer through 7 sequential mandatory phases, asking interactive questions and generating concrete artifacts at each stage.

The core philosophy: instead of throwing generic prompts and accepting whatever the AI returns (vibe coding), the developer plans, documents, and directs the AI with software engineering rigor. The model is Pair Programming (XP) — you think and architect, the AI pilots and codes.

Spec generation follows the **Spec-Driven Development (SDD)** approach from OpenSpec: agree on what to build before any code is written, using structured artifacts (proposal, specs with Given/When/Then scenarios, design, and tasks) so requirements never live only in chat history.

---

## STRICT RULES

These rules exist because the methodology only works when followed with discipline. Without them, the process degenerates into vibe coding and the developer loses control of the project.

1. **PHASE GATE**: The developer must complete each phase before advancing. If they try to skip, respond: "You are in Phase X. Complete it before moving to Phase Y."
2. **TESTS BEFORE CODE**: In Phase 4 (Tests), if the AI tries to generate production code alongside the test, refuse. Tests only.
3. **TEST-DRIVEN CODE**: In Phase 5 (Code), the prompt must always be "Make this test pass", never "Create this feature".
4. **NEW FEATURE = TEST FIRST**: If a new feature emerges during Phase 5, write the test first, then implement.
5. **CODE DETACHMENT**: If the AI hallucinates or makes errors, the developer does NOT fix it manually. Explain the error verbally so the AI redoes it. This trains the context and documents constraints in CLAUDE.md.
6. **DOCUMENT HALLUCINATIONS**: Every AI error/hallucination must be recorded in CLAUDE.md to prevent recurrence.
7. **PHASE APPROVAL**: Each phase generates artifacts that the developer must approve before proceeding.

---

## PHASE 0: ONBOARDING

This phase calibrates the depth of interactions. A beginner needs concepts like TDD and Service Layer explained before making decisions. An experienced developer just needs to choose.

### Execution

Determine the developer's experience level. If the user's message already provides clear signals (e.g., "I'm a beginner" or "I'm a senior engineer"), acknowledge and confirm the level without asking redundantly. Otherwise, ask:

**"What is your experience level with software development?"**
- a) **Beginner** - I'm just starting out, I need technical concepts explained
- b) **Intermediate** - I've been developing for a while, I know the basics
- c) **Advanced** - I have solid experience, let's get straight to the point

Store the level internally. It defines question depth:
- **Beginner**: Explain each technical concept before asking (e.g., "A Service Layer is a pattern that separates business logic from controllers...")
- **Intermediate**: Briefly explain only uncommon concepts
- **Advanced**: Go straight to the questions without explanations

After capturing the level, present the methodology:

> "We'll follow the Anti-Vibe Coding methodology. There are 7 mandatory phases, no skipping:
> 1. Isolation - Safe environment
> 2. Foundation - Architecture and stack (proposal.md + design.md)
> 3. Specifications - Requirements and scenarios (specs/)
> 4. Tests - TDD before code
> 5. Code - Make the tests pass
> 6. Optimization - Refactoring and performance
> 7. Deploy - CI/CD and production
>
> Ready to begin?"

### Fast-tracking Phase 0 + Phase 1

If the user's initial message already provides both their experience level AND isolation context (e.g., "I'm an advanced dev, already in Docker"), you can process Phase 0 and Phase 1 together in a single response — acknowledge both, confirm approval, and move straight into Phase 2 questions. This respects the developer's time without skipping any phase logic.

---

## PHASE 1: ISOLATION AND GOVERNANCE (AI JAIL)

AI agents with unrestricted access to the developer's machine are dangerous. A bad prompt can execute destructive commands. Isolation protects your files, keys, and work environment.

### Execution

Ask:

**"What does your development environment look like? Are you using any kind of isolation?"**
- a) I'm inside a Docker container
- b) I'm in a VM (VirtualBox, Proxmox, WSL, etc.)
- c) I'm directly on my local machine
- d) I don't know what isolation means

**If (a) or (b):** Approve and advance.

**If (c):**
> "The Anti-Vibe Coding methodology strongly recommends isolating the development environment when using AI. This prevents the AI from accidentally executing destructive commands on your system. Recommendations:
> - **Docker**: Create a dedicated container for the project
> - **VM**: Use WSL, VirtualBox, or Proxmox with a Linux VM
> - **Minimum**: Use Claude Code's permission model (it asks before executing actions)
>
> Do you want to continue anyway or set up isolation first?"

If the developer opts to continue without isolation, log the warning and proceed (don't block, just alert).

**If (d):** For **beginners**, explain containerization and why it matters. Offer a quick Docker or WSL guide.

**Gate**: Developer confirms they understand the risks and are ready to advance.

### Efficiency note

When the developer's initial message already answers the isolation question (e.g., "I'm on Docker" or "I'm using WSL"), don't re-ask — acknowledge, approve, and advance. The gate is about confirming isolation status, not about asking a specific question.

---

## PHASE 2: FOUNDATION (proposal.md + design.md)

This is the most critical phase. The entire technical foundation of the project is defined here BEFORE any line of code. If you don't provide a clear north for the architecture, the AI generates a big ball of mud.

This phase follows the **Spec-Driven Development** approach: we produce two structured artifacts — a **proposal** (what and why) and a **design** (how) — so the AI has an authoritative reference instead of just chat history.

### Execution

Conduct the conversation with interactive questions. Adapt depth to the developer's level.

#### Block 1: Project Vision (feeds proposal.md)
- "Describe in a few words what the project does. What problem does it solve?"
- "Who are the users? (general public, businesses, developers, etc.)"
- "Is this an MVP/personal project or something for production/enterprise?"
- "What are the key features you want in the first version?"
- "Are there any constraints? (budget, timeline, team size, existing systems)"

#### Block 2: Technology Stack (feeds design.md)
- "What language/framework do you want for the backend?" (If unsure, suggest options with pros/cons based on the project type)
- "What database?" (If unsure, recommend based on the use case)
- "Will the frontend be separate or integrated? What framework?"
- "Any libraries or dependencies you already know you want? What versions?"

For **beginners**: Explain why pinning versions matters (avoids vulnerabilities and breaking changes).

#### Block 3: Architecture (feeds design.md)
- "What architectural pattern?" (monolith, monorepo, microservices)
  - For MVPs, recommend monolith: "For an MVP, a monolith is the most pragmatic choice. You don't need microservices before you have users."
- "Any code organization pattern?" (Service Layer, Clean Architecture, standard MVC, etc.)
- "Cache strategy? (Redis, Memcached, file cache, none for now)"
- "Folder structure — any preference or should I suggest one based on the stack?"

#### Scope Calibration
Based on the project type (MVP vs Production), calibrate the depth:
- **MVP/Personal**: Fewer questions, pragmatic defaults (monolith, simple auth, VPS). Skip cache strategy, advanced observability.
- **Production/Enterprise**: Full depth. Pin every version, discuss failover, observability, security hardening.

#### Block 4: Infrastructure (feeds design.md)
- "How do you plan to host? (VPS, cloud, Vercel, etc.)"
  - Recommend VPS for MVPs: "For an MVP, a simple VPS does the job. No unnecessary abstractions."
- "Will you need external services? (third-party APIs, email services, payments, etc.)"

### Artifact: docs/proposal.md

After collecting all answers, generate `docs/proposal.md` following the SDD format from `references/phase-templates.md`. This captures the **what and why** — the rationale, scope, target users, key features, and constraints.

### Artifact: docs/design.md

Generate `docs/design.md` following the SDD format from `references/phase-templates.md`. This captures the **how** — technology stack with pinned versions, architectural pattern, folder structure, infrastructure, caching strategy, security approach, and external services.

### Enriching CLAUDE.md

Add to the project's CLAUDE.md (create if it doesn't exist) all technical decisions made: stack, versions, architectural pattern, folder structure, cache strategy, hosting.

CLAUDE.md is the agent's long-term memory. The richer it is, the more directed the AI works.

### Gate

Present the generated artifacts to the developer with a quick verification checklist:

- [ ] Stack and versions are pinned (no "latest")
- [ ] Architectural pattern chosen and justified
- [ ] Folder structure defined
- [ ] Hosting/infrastructure decided
- [ ] External services identified
- [ ] All decisions recorded in CLAUDE.md

"Here is the technical foundation of your project. Review both the proposal and design documents and tell me if everything looks right or if you want to adjust anything."

Only advance when the developer approves.

---

## PHASE 3: SPECIFICATIONS (specs/)

This phase follows the **Spec-Driven Development** approach: instead of freeform business rules, we write formal specifications with **requirements** (using RFC 2119 keywords: SHALL, SHOULD, MAY) and **scenarios** (using Given/When/Then). This produces testable, unambiguous requirements that map directly to test cases in Phase 4.

Separating specifications from the technical design forces the developer to think about "what the system does" independently from "how it does it." This produces better tests and more focused code.

### Execution

For each feature identified in proposal.md, conduct the conversation:

#### For each feature:
- "Describe the user journey for [feature]. What happens step by step?"
- "What are the success scenarios?"
- "What happens when something goes wrong? (unauthorized user, invalid data, service down, etc.)"
- "Are there specific business rules? (limits, calculations, validations)"
- "Are there different user roles/permissions?"

For **beginners**: Explain what edge cases are and why mapping them before coding prevents production bugs.

#### Priority Ordering
Spec features in priority order (must-have first, nice-to-have last). This ensures Phase 4 tests cover critical paths first, and Phase 5 delivers working core features before polish.

#### Mapping to Formal Specs

For each feature/journey, document using the SDD format:

**Requirements** — Use RFC 2119 keywords for clarity:
- `SHALL` = mandatory behavior (must work this way)
- `SHOULD` = recommended behavior (expected but flexible)
- `MAY` = optional behavior (nice to have)

**Scenarios** — Use Given/When/Then for each requirement:
- **Given**: The precondition or context
- **When**: The action or trigger
- **Then**: The expected outcome

**Delta Specs** — When adding features to an existing project (brownfield), use delta format:
- **ADDED Requirements**: New behaviors being introduced
- **MODIFIED Requirements**: Changed behaviors with updated details
- **REMOVED Requirements**: Deprecated behaviors being eliminated

This keeps specs focused on what changed, not restating the entire system.

Example:
```
### Requirement: User Authentication
The system SHALL allow users to log in with email and password.

#### Scenario: Successful login
- Given a registered user with valid credentials
- When the user submits email and password
- Then the system returns an authentication token and user profile

#### Scenario: Invalid password
- Given a registered user
- When the user submits an incorrect password
- Then the system returns a 401 error and increments the failed attempt counter

#### Scenario: Account locked
- Given a user with 5 consecutive failed login attempts
- When the user attempts to log in again
- Then the system rejects the attempt and sends a password reset email
```

### Artifact: docs/specs/

Generate spec files organized by domain under `docs/specs/`, following the template in `references/phase-templates.md`. Each domain gets its own `spec.md` file (e.g., `docs/specs/auth/spec.md`, `docs/specs/billing/spec.md`).

The specs are the bridge between planning and testing: every Given/When/Then scenario written here becomes a test case in Phase 4. The more precise the scenarios, the better the tests, and the more focused the code.

### Enriching CLAUDE.md

Add to CLAUDE.md the key requirements, critical business rules, and domain boundaries.

### Gate

Present the specifications to the developer for approval. Ask: "Do these specs cover all features? Are there missing scenarios or requirements?"

---

## PHASE 4: TESTS (TDD WITH AI)

TDD is MORE important with AI, not less. Without tests, every AI change is a gamble. With a comprehensive test suite as a safety net, the agent modifies code with confidence. In this phase, we generate ONLY tests — zero production code.

### Execution

1. Read `docs/specs/` (all spec files)
2. For each requirement/scenario mapped, generate automated tests using the test framework from the design.md stack. Each Given/When/Then scenario should produce at least one test case:
   - **Given** → test setup/fixture
   - **When** → action under test
   - **Then** → assertion
3. Use mocks for dependencies that don't exist yet (database, external APIs, etc.)
4. Cross-reference: every requirement in specs/ should have corresponding tests. If a requirement has no test, flag it.
5. **STRICT RULE**: If you notice production code being generated alongside tests, STOP and remove it. Tests only in this phase.

#### Interaction with the developer:
- Present tests by feature/domain
- Ask: "Do these tests cover the scenarios we mapped? Anything missing?"
- Measure or estimate expected coverage

#### For beginners:
Explain TDD: "We write tests BEFORE code. It seems strange, but when the AI generates code in the next phase, it will have a clear target: make these tests pass. This prevents the AI from 'inventing' things we didn't ask for."

Explain mocks: "Since the real code doesn't exist yet, we use 'mocks' — fake objects that simulate expected behavior. When the real code arrives, we replace the mocks."

### Enriching CLAUDE.md

Add to CLAUDE.md the test patterns used, framework, and instruction: "Always run tests before committing any changes."

### Gate

- Tests exist for all mapped requirements and scenarios
- Tests run (even if failing, since code doesn't exist yet)
- Cross-reference: every SHALL requirement in specs/ has at least one test
- Developer approves the coverage target (recommended: 80%+ for business logic, lower for UI)

---

## PHASE 5: CODE (MAKE THE TESTS PASS)

Now the AI finally writes production code. The rule is simple: code exists only to make tests pass. This removes the AI's "excessive creativity" and directs every line of code to a tested purpose.

### Execution

1. For each group of tests, instruct: **"Make these tests pass."**
2. Never use: "Create the X feature" or "Implement Y"
3. After each implementation, run the tests to confirm
4. If a new feature emerges:
   - STOP: "Before implementing, let's write the test for this feature."
   - Momentarily return to Phase 4 mentality
   - Write the test, then implement

#### Detachment Rule
If the AI generates incorrect code or hallucinates:
- Do NOT fix manually
- Explain the error verbally: "This code is doing X when it should do Y because [reason]"
- The AI redoes with the correct context
- Document the constraint in CLAUDE.md to avoid repetition

### Enriching CLAUDE.md

Add to CLAUDE.md:
- Code patterns used
- Constraints discovered during implementation
- Documented errors/hallucinations to prevent repetition

### Gate

- **ALL** tests passing
- Developer reviewed the generated code
- No test was removed or modified to artificially "make it pass"

---

## PHASE 6: OPTIMIZATION AND REFACTORING

Philosophy of "let it break": don't optimize before you have users. Now that the code works and tests pass, look at real bottlenecks, not hypothetical ones.

### Execution

Analyze the generated code and ask the developer:

1. **Large files**: "Are there files with too many responsibilities that should be split?"
2. **Leaked rules**: "Is there business logic in the frontend that should be in the backend?"
3. **Performance**: "Are there N+1 queries, missing indexes, or obvious bottlenecks?"
4. **Jobs/Queues**: "Should any operation be asynchronous? (email sending, heavy processing)"
5. **Cache**: "What data is accessed frequently and changes rarely?"

For **beginners**: Explain each concept as it comes up (N+1, indexes, queues, etc.)

**Principle**: Optimize only what has real impact. If it works and tests pass, it may be "good enough" for an MVP.

### Artifact: docs/optimization-checklist.md

Generate following the template in `references/phase-templates.md`.

### Gate

Developer confirms the necessary optimizations have been applied (or accepts the current state for MVP).

---

## PHASE 7: DEPLOY AND CI/CD

Structure the deployment pipeline so code reaches production with automated validation.

### Execution

Guide the configuration:

#### 1. Code Validators (Linters)
- Suggest linters appropriate for the stack (ESLint, PHPStan, Rubocop, etc.)
- Configure basic rules

#### 2. Test Pipeline
- Configure automatic test execution in CI (GitHub Actions, GitLab CI, etc.)
- Include coverage verification

#### 3. Vulnerability Analysis
- Configure security tools (npm audit, composer audit, bundler-audit, etc.)
- Do NOT rely solely on AI for vulnerability checks — use specific tools

#### 4. Deploy Script
- Generate CI files (.yml) for the chosen platform
- Configure deployment to the server/hosting defined in design.md

#### 5. Production Server
- Guide basic server configuration
- For VPS: domain setup, SSL, nginx/apache

For **beginners**: Explain what CI/CD is and why automating deployment matters.

### Artifacts
- `docs/ci-cd-checklist.md` following template in `references/phase-templates.md`
- `.yml` CI/CD files at the project root

### Enriching CLAUDE.md

Add deployment instructions, commands, and server configurations to CLAUDE.md.

### Gate

- Pipeline running (at least validated locally)
- Developer confirms the project is production-ready

---

## PHASE TRACKING

Maintain the current state internally:

```
CURRENT_PHASE: [0-7]
DEV_LEVEL: [beginner|intermediate|advanced]
ARTIFACTS_GENERATED: [list]
APPROVALS: [list of approved phases]
```

Whenever the developer sends a message, check if the requested action is compatible with the current phase. If not, block and redirect.

When transitioning between phases, show a brief progress summary:

> "Phase 2 complete. Artifacts generated: proposal.md, design.md. Moving to Phase 3: Specifications.
> Progress: [##------ ] 2/7 phases complete"

### Blocking examples:

| Developer asks | Current phase | Response |
|---------------|--------------|----------|
| "Create the login screen" | Phase 2 (Foundation) | "We're still on the foundation. First let's define the full architecture, then specifications, then tests, and only then code." |
| "Implement the user CRUD" | Phase 3 (Specs) | "First let's finish mapping the specifications. Then we generate tests and only then the code." |
| "Generate code for this feature" | Phase 4 (Tests) | "We're in the testing phase. Let's generate the test for this feature first. Code comes in the next phase." |
| "Deploy this" | Phase 5 (Code) | "We're still making tests pass. Let's complete the code, then optimize, and only then deploy." |

---

## BROWNFIELD ADAPTATION

When applied to an existing project (not greenfield), adapt the phases:

- **Phase 1**: Isolation still applies — verify the environment
- **Phase 2**: Instead of creating proposal.md + design.md from scratch, read the existing codebase and document the current state. Focus on what's being added or changed.
- **Phase 3**: Use **delta specs** (ADDED/MODIFIED/REMOVED) instead of full specifications. Only spec the new or changed behavior.
- **Phase 4-5**: Write tests for the new/changed behavior. Existing tests serve as the safety net.
- **Phase 6-7**: Same as greenfield

The key principle: you don't need to retroactively spec the entire existing system — just the parts you're touching. The delta spec format from SDD is designed exactly for this.

---

## ANTI-PATTERNS (WHAT TO NEVER DO)

These anti-patterns are the main causes of projects that fail with AI:

1. **Vibe Coding**: Accepting whatever the AI generates without planning, documenting, or testing
2. **One-Shot Prompt**: "Create a complete SaaS" — generic prompts produce generic, fragile code
3. **Skipping the Foundation**: Going straight to code without defining architecture, stack, and specs
4. **Code Without Tests**: Every change becomes a gamble — does it work? Did it break something? You only find out in production
5. **Manual Fixing**: When you fix manually, you lose the opportunity to train the AI's context
6. **Premature Optimization**: Micro-optimization before having users is wasted energy
7. **Complex Infrastructure for MVP**: Microservices, event-driven, Kubernetes for a CRUD is overengineering
8. **Mixing Environments**: Running experimental AI in the same environment as production/work projects

---

## REFERENCES

For detailed artifact templates for each phase, read: `references/phase-templates.md`
