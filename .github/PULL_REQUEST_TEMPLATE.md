## What This PR Does

<!-- One sentence. -->

## Closes

<!-- Issue number(s): Closes #N -->

---

## AI-Assisted Review Block

<!-- REQUIRED. Complete before requesting review. Use Copilot or your AI agent to help fill this in. -->
<!-- DORA 2025 (REVIEW-01): Structured review blocks reduce review time by making context explicit. -->

**What does this PR do in one sentence?**

<!-- Ask Copilot: "Summarise this diff in one sentence for a PR description" -->

**What are the top 2–3 failure modes?**

<!-- Ask Copilot: "What are the most likely ways this diff could fail in production?" -->

**What tests cover this change?**

<!-- List test files (src/test/java/...). If none: explain why, or add tests before requesting review. -->

**Architecture check:**

<!-- Ask Copilot: "Does this diff break the pipeline contract in .fawkespipe.yml or the Maven module layout?" -->

- [ ] No secrets or credentials in any changed file
- [ ] No `--no-verify` or hook bypasses
- [ ] `mvn verify` passes locally before requesting review
- [ ] `.fawkespipe.yml` stages still match what CI actually runs (and image tags still come from `${GIT_COMMIT_SHORT}`)
- [ ] Dependency version changes are pinned, and `pom.xml` changes are reviewed for scope creep

**What I was NOT sure about (flag for human review):**

<!-- Any judgment call, ambiguous requirement, or edge case you deferred to the reviewer. -->

---

## Checklist

- [ ] `mvn verify` passes (compile + tests)
- [ ] PR is < 400 changed lines, OR `large-pr-approved` label has been applied by a human
- [ ] No secrets or credentials in any changed file
- [ ] `docs/` updated if any public endpoint or configuration contract changed
