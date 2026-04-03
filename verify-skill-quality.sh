#!/bin/bash
# Deep Skill Quality Scorer for anti-vibe-coding (0-100)
# 25 checks, 4 points each = 100 total

SKILL="anti-vibe-coding/SKILL.md"
TEMPLATES="anti-vibe-coding/references/phase-templates.md"
SCORE=0

# === 1. No Portuguese in SKILL.md (4 pts) ===
PT=$(grep -ciE '\b(voce|nao|codigo|projeto|fase [0-9]|regra|artefato|metodologia akita|ai jo|cenario feliz|camada|hospedagem)\b' "$SKILL" 2>/dev/null | tr -d '[:space:]'); PT=${PT:-0}
[ "$PT" -eq 0 ] && SCORE=$((SCORE + 4))

# === 2. No Portuguese in templates (4 pts) ===
PT2=$(grep -ciE '\b(voce|nao|codigo|projeto)\b' "$TEMPLATES" 2>/dev/null | tr -d '[:space:]'); PT2=${PT2:-0}
[ "$PT2" -eq 0 ] && SCORE=$((SCORE + 4))

# === 3. SDD artifacts: proposal.md + design.md + specs/ (4 pts) ===
S3=0; grep -qi "proposal.md" "$SKILL" && S3=$((S3+1)); grep -qi "design.md" "$SKILL" && S3=$((S3+1)); grep -qi "specs/" "$SKILL" && S3=$((S3+1))
[ "$S3" -ge 3 ] && SCORE=$((SCORE + 4))

# === 4. Given/When/Then + RFC 2119 (4 pts) ===
S4=0; grep -qi "Given/When/Then\|given.*when.*then" "$SKILL" && S4=$((S4+1)); grep -qi "RFC 2119" "$SKILL" && S4=$((S4+1)); grep -qi "SHALL.*SHOULD.*MAY\|SHALL, SHOULD, MAY" "$SKILL" && S4=$((S4+1))
[ "$S4" -ge 2 ] && SCORE=$((SCORE + 4))

# === 5. All 8 phases present (4 pts) ===
PH=0; for i in 0 1 2 3 4 5 6 7; do grep -qi "PHASE $i" "$SKILL" && PH=$((PH+1)); done
[ "$PH" -eq 8 ] && SCORE=$((SCORE + 4))

# === 6. Description > 400 chars with trigger words (4 pts) ===
DESC=$(sed -n '3p' "$SKILL"); DL=$(echo "$DESC" | wc -c | tr -d '[:space:]')
S6=0; echo "$DESC" | grep -qi "SaaS\|MVP\|new project" && S6=$((S6+1)); echo "$DESC" | grep -qi "spec-driven\|SDD" && S6=$((S6+1)); [ "$DL" -gt 400 ] && S6=$((S6+1))
[ "$S6" -ge 3 ] && SCORE=$((SCORE + 4))

# === 7. Adaptive beginner support (4 pts) ===
grep -qi "beginner.*explain\|beginner.*concept" "$SKILL" && SCORE=$((SCORE + 4))

# === 8. Adaptive intermediate support (4 pts) ===
grep -qi "intermediate.*briefly\|intermediate.*uncommon" "$SKILL" && SCORE=$((SCORE + 4))

# === 9. Adaptive advanced support (4 pts) ===
grep -qi "advanced.*straight\|advanced.*skip\|advanced.*no.*explanation" "$SKILL" && SCORE=$((SCORE + 4))

# === 10. Fast-tracking Phase 0+1 (4 pts) ===
grep -qi "fast-track" "$SKILL" && grep -qi "Phase 0 and Phase 1\|Phase 0.*Phase 1.*together" "$SKILL" && SCORE=$((SCORE + 4))

# === 11. Phase gates & blocking (4 pts) ===
grep -qi "PHASE GATE" "$SKILL" && grep -qi "CURRENT_PHASE" "$SKILL" && SCORE=$((SCORE + 4))

# === 12. TDD emphasis (4 pts) ===
S12=0; grep -qi "tests before code\|TDD before code" "$SKILL" && S12=$((S12+1)); grep -qi "make.*test.*pass" "$SKILL" && S12=$((S12+1)); grep -qi "test first" "$SKILL" && S12=$((S12+1))
[ "$S12" -ge 2 ] && SCORE=$((SCORE + 4))

# === 13. CLAUDE.md enrichment >= 5 mentions (4 pts) ===
EN=$(grep -ci "CLAUDE.md" "$SKILL" 2>/dev/null | tr -d '[:space:]'); EN=${EN:-0}
[ "$EN" -ge 5 ] && SCORE=$((SCORE + 4))

# === 14. Anti-patterns section with >= 5 patterns (4 pts) ===
grep -qi "ANTI-PATTERN" "$SKILL" && AP=$(grep -ci "vibe coding\|one.shot\|premature\|overengineering\|manual fix\|mixing\|skipping\|code without" "$SKILL" | tr -d '[:space:]') && [ "${AP:-0}" -ge 5 ] && SCORE=$((SCORE + 4))

# === 15. Code detachment + hallucination docs (4 pts) ===
grep -qi "detachment\|do NOT fix manually" "$SKILL" && grep -qi "hallucination" "$SKILL" && SCORE=$((SCORE + 4))

# === 16. Spec-to-test bridge (4 pts) ===
grep -qi "scenario.*becomes.*test\|scenario.*test case\|specs.*bridge.*test\|map.*directly.*test" "$SKILL" && SCORE=$((SCORE + 4))

# === 17. Isolation security rationale (4 pts) ===
grep -qi "destructive command\|dangerous" "$SKILL" && grep -qi "docker\|container" "$SKILL" && SCORE=$((SCORE + 4))

# === 18. Templates: proposal + design + specs + checklist (4 pts) ===
T=0; grep -qi "proposal" "$TEMPLATES" && T=$((T+1)); grep -qi "design" "$TEMPLATES" && T=$((T+1)); grep -qi "Given.*When.*Then" "$TEMPLATES" && T=$((T+1)); grep -qi "checklist" "$TEMPLATES" && T=$((T+1))
[ "$T" -ge 4 ] && SCORE=$((SCORE + 4))

# === 19. Skill under 500 lines (4 pts) ===
LINES=$(wc -l < "$SKILL" | tr -d '[:space:]')
[ "$LINES" -le 500 ] && SCORE=$((SCORE + 4))

# === 20. Code examples (```blocks) >= 2 (4 pts) ===
EX=$(grep -c '```' "$SKILL" 2>/dev/null | tr -d '[:space:]'); EX=${EX:-0}
[ "$EX" -ge 2 ] && SCORE=$((SCORE + 4))

# === 21. Strict rules section (4 pts) ===
grep -qi "STRICT RULES" "$SKILL" && SCORE=$((SCORE + 4))

# === 22. Pair Programming / XP reference (4 pts) ===
grep -qi "pair programming\|XP" "$SKILL" && SCORE=$((SCORE + 4))

# === 23. OpenSpec / SDD attribution (4 pts) ===
grep -qi "OpenSpec\|openspec\|Spec-Driven Development" "$SKILL" && SCORE=$((SCORE + 4))

# === 24. Blocking examples table (4 pts) ===
grep -qi "blocking example\|Developer asks.*Current phase\|Create the login" "$SKILL" && SCORE=$((SCORE + 4))

# === 25. Efficiency note for Phase 1 (4 pts) ===
grep -qi "efficiency note\|don.*re-ask\|already answers the isolation" "$SKILL" && SCORE=$((SCORE + 4))

[ "$SCORE" -gt 100 ] && SCORE=100
echo "$SCORE"
