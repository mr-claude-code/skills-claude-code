#!/bin/bash
# Granular Skill Quality Scorer for anti-vibe-coding (0-100)
# Each check is worth specific points, total = 100

SKILL="anti-vibe-coding/SKILL.md"
TEMPLATES="anti-vibe-coding/references/phase-templates.md"
SCORE=0

# === 1. NO PORTUGUESE REMNANTS (8 pts) ===
PT=$(grep -ciE '\b(voce|nao|codigo|projeto|fase|regra|artefato|metodologia akita|ai jo|metodo akita|cenario feliz|camada|hospedagem)\b' "$SKILL" 2>/dev/null | tr -d '[:space:]')
PT=${PT:-0}
[ "$PT" -eq 0 ] && SCORE=$((SCORE + 4))
PT2=$(grep -ciE '\b(voce|nao|codigo|projeto)\b' "$TEMPLATES" 2>/dev/null | tr -d '[:space:]')
PT2=${PT2:-0}
[ "$PT2" -eq 0 ] && SCORE=$((SCORE + 4))

# === 2. SDD CORE ARTIFACTS (12 pts) ===
grep -qi "proposal.md" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "design.md" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "specs/" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "given.*when.*then\|Given/When/Then" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "RFC 2119" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "SHALL.*SHOULD.*MAY\|SHALL, SHOULD, MAY" "$SKILL" && SCORE=$((SCORE + 2))

# === 3. ALL 8 PHASES PRESENT (8 pts, 1 each) ===
grep -qi "PHASE 0" "$SKILL" && SCORE=$((SCORE + 1))
grep -qi "PHASE 1" "$SKILL" && SCORE=$((SCORE + 1))
grep -qi "PHASE 2" "$SKILL" && SCORE=$((SCORE + 1))
grep -qi "PHASE 3" "$SKILL" && SCORE=$((SCORE + 1))
grep -qi "PHASE 4" "$SKILL" && SCORE=$((SCORE + 1))
grep -qi "PHASE 5" "$SKILL" && SCORE=$((SCORE + 1))
grep -qi "PHASE 6" "$SKILL" && SCORE=$((SCORE + 1))
grep -qi "PHASE 7" "$SKILL" && SCORE=$((SCORE + 1))

# === 4. DESCRIPTION QUALITY (8 pts) ===
DESC=$(sed -n '3p' "$SKILL")
echo "$DESC" | grep -qi "new project\|SaaS\|MVP" && SCORE=$((SCORE + 2))
echo "$DESC" | grep -qi "spec-driven\|SDD" && SCORE=$((SCORE + 2))
echo "$DESC" | grep -qi "scaffold\|bootstrap\|from scratch\|from zero" && SCORE=$((SCORE + 2))
DESC_LEN=$(echo "$DESC" | wc -c | tr -d '[:space:]')
[ "$DESC_LEN" -gt 400 ] && SCORE=$((SCORE + 2))

# === 5. ADAPTIVE EXPERIENCE LEVELS (6 pts) ===
grep -qi "beginner.*explain\|beginner.*concept" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "intermediate.*briefly\|intermediate.*uncommon" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "advanced.*straight\|advanced.*skip" "$SKILL" && SCORE=$((SCORE + 2))

# === 6. FAST-TRACKING (4 pts) ===
grep -qi "fast-track\|fast track" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "Phase 0.*Phase 1.*together\|process.*both.*phases\|Phase 0 and Phase 1" "$SKILL" && SCORE=$((SCORE + 2))

# === 7. PHASE GATES & DISCIPLINE (6 pts) ===
grep -qi "PHASE GATE\|phase gate" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "CURRENT_PHASE" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "blocking example\|block.*redirect" "$SKILL" && SCORE=$((SCORE + 2))

# === 8. TDD EMPHASIS (6 pts) ===
grep -qi "tests before code\|TDD before code\|test.*before.*code" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "make.*test.*pass\|make these tests pass" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "new feature.*test first\|test first" "$SKILL" && SCORE=$((SCORE + 2))

# === 9. CLAUDE.MD ENRICHMENT (4 pts) ===
ENRICHMENT=$(grep -ci "CLAUDE.md" "$SKILL" 2>/dev/null | tr -d '[:space:]')
ENRICHMENT=${ENRICHMENT:-0}
[ "$ENRICHMENT" -ge 5 ] && SCORE=$((SCORE + 4)) || { [ "$ENRICHMENT" -ge 3 ] && SCORE=$((SCORE + 2)); }

# === 10. ANTI-PATTERNS (4 pts) ===
grep -qi "ANTI-PATTERN" "$SKILL" && SCORE=$((SCORE + 2))
AP_COUNT=$(grep -ci "vibe coding\|one.shot\|premature\|overengineering\|manual fix" "$SKILL" 2>/dev/null | tr -d '[:space:]')
AP_COUNT=${AP_COUNT:-0}
[ "$AP_COUNT" -ge 4 ] && SCORE=$((SCORE + 2))

# === 11. CODE DETACHMENT RULE (4 pts) ===
grep -qi "detachment\|do not fix manually\|does NOT fix.*manually" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "hallucination\|document.*error\|DOCUMENT HALLUCINATIONS" "$SKILL" && SCORE=$((SCORE + 2))

# === 12. SPEC-TO-TEST BRIDGE (4 pts) ===
grep -qi "scenario.*test case\|Given/When/Then.*test\|specs.*bridge.*test\|scenario.*becomes.*test" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "requirement.*scenario.*map\|map.*directly.*test" "$SKILL" && SCORE=$((SCORE + 2))

# === 13. ISOLATION SECURITY RATIONALE (4 pts) ===
grep -qi "destructive command\|dangerous\|protect.*files" "$SKILL" && SCORE=$((SCORE + 2))
grep -qi "docker\|container\|WSL\|VM" "$SKILL" && SCORE=$((SCORE + 2))

# === 14. TEMPLATE FILE QUALITY (8 pts) ===
grep -qi "proposal" "$TEMPLATES" && SCORE=$((SCORE + 2))
grep -qi "design" "$TEMPLATES" && SCORE=$((SCORE + 2))
grep -qi "Given.*When.*Then\|given.*when.*then" "$TEMPLATES" && SCORE=$((SCORE + 2))
grep -qi "optimization\|ci-cd\|checklist" "$TEMPLATES" && SCORE=$((SCORE + 2))

# === 15. CONCISENESS — SKILL UNDER 500 LINES (4 pts) ===
LINES=$(wc -l < "$SKILL" | tr -d '[:space:]')
[ "$LINES" -le 500 ] && SCORE=$((SCORE + 4)) || { [ "$LINES" -le 600 ] && SCORE=$((SCORE + 2)); }

# === 16. EXAMPLES IN SKILL (4 pts) ===
EXAMPLES=$(grep -c '```' "$SKILL" 2>/dev/null | tr -d '[:space:]')
EXAMPLES=${EXAMPLES:-0}
[ "$EXAMPLES" -ge 2 ] && SCORE=$((SCORE + 2))
grep -qi "example\|Example" "$SKILL" && SCORE=$((SCORE + 2))

# === 17. STRICT RULES SECTION (2 pts) ===
grep -qi "STRICT RULES" "$SKILL" && SCORE=$((SCORE + 2))

# Cap at 100
[ "$SCORE" -gt 100 ] && SCORE=100

echo "$SCORE"
