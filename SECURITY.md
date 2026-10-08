# Security Policy — java-fawkes-path

## Supported versions

| Version         | Supported                                    |
| --------------- | -------------------------------------------- |
| `main` branch   | ✅ Active — patches applied here first       |
| Tagged releases | ✅ Critical fixes backported where practical |
| Older releases  | ❌ No active support                         |

---

## Reporting a vulnerability

**Do not open a public GitHub issue for security vulnerabilities.**

Report privately using one of these channels, in order of preference:

1. **GitHub private vulnerability reporting** (preferred):
   [Security → Report a vulnerability](https://github.com/paruff/java-fawkes-path/security/advisories/new)
   — this keeps the report confidential until a fix is published.

2. **Email**: Contact the maintainer via the email address on the
   [paruff GitHub profile](https://github.com/paruff). Use the subject line
   `[java-fawkes-path] Security report`.

Include in your report:

- Affected component (e.g. Spring Boot endpoint, Maven dependency, Dockerfile, GitHub Actions workflow)
- Steps to reproduce or a minimal proof of concept
- Your assessment of severity and impact
- Whether you have already disclosed this elsewhere

---

## Response timeline

| Stage                                  | Target                                            |
| -------------------------------------- | ------------------------------------------------- |
| Acknowledgement                        | Within 72 hours of receipt                        |
| Initial triage and severity assessment | Within 5 business days                            |
| Fix or mitigation published            | Depends on severity (see below)                   |
| Public disclosure                      | After fix is available, coordinated with reporter |

**Severity guidelines:**

- **Critical** (CVSS ≥ 9.0): fix targeted within 7 days
- **High** (CVSS 7.0–8.9): fix targeted within 14 days
- **Medium / Low**: addressed in the next scheduled release

We will credit reporters in release notes unless you request anonymity.

---

## Scope

This policy covers the java-fawkes-path repository and its default
configuration. It does not cover:

- **Third-party components** — Spring Boot, the JDK, Maven, base container
  images, and the reusable workflows in
  [paruff/fawkes](https://github.com/paruff/fawkes). Report upstream
  vulnerabilities to those projects; we update pinned versions when upstream
  patches are available.
- **Deployments built from modified manifests or configuration.**
- **The rest of the Fawkes suite** — each repo carries its own security policy.

---

## Security gates in this repo

CI (`.github/workflows/ci.yml`) runs the suite's reusable
`reusable-security-scanning`, `reusable-sbom-generation` and
`reusable-image-signing` workflows against every image build. These block
known-vulnerable dependencies and images at the gate.

They are a gate, not a guarantee: review any code you add on top of this
golden path before you expose it.

## Known constraints

**The sample API is unauthenticated.** `/health`, `/info` and the metrics
endpoint are served without authentication, because this repo proves the
pipeline rather than hosting a production service. Do not expose it beyond
localhost without adding authentication and TLS.

**Image promotion writes to a GitOps repo.** On a green `main` build the
workflow opens a PR that bumps the image tag in the companion GitOps repo.
Review those PRs like any other change with cluster reach.
