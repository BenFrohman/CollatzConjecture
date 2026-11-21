# Kernel certificate: CollatzConjecture

This file records a local machine check of the Lean 4 development in this repository. Lean does not issue a signed certificate. What is recorded here is the toolchain, the `lake build` result, a scan for `sorry` / `admit` / `native_decide` / `axiom`, and `Lean.collectAxioms` (the function behind `#print axioms`) on every theorem in the built modules.

| Item | Value |
|---|---|
| Repository | https://github.com/BenFrohman/CollatzConjecture |
| lean-toolchain | `leanprover/lean4:v4.30.0-rc1` |
| Lean | Lean (version 4.30.0-rc1, x86_64-apple-darwin24.6.0, commit 714601baf118066cbf3f282361339c6d06665b2a, Release) |
| Mathlib | none |
| Date (UTC) | 2026-11-21T22:20:04Z |
| `lake build` | `Build completed successfully (5 jobs).` |
| sorry / admit / native_decide / axiom scan | `RESULT: 0 hits` ([sorry-scan.txt](sorry-scan.txt)) |
| `#print axioms` | `AUDIT PASS: 19 theorems in 1 modules depend only on propext, Classical.choice, Quot.sound (or on no axioms)` ([axioms.txt](axioms.txt)) |

The sibling repositories `collatz-teaming-lemma` and `collatz-terras-density` use Lean 4.34.0 and also replay modules with `leanchecker`. This tree is pinned to `v4.30.0-rc1`, and `leanchecker` was not run. The axiom lines come from `collectAxioms` after `lake build`.

## Scope

`CollatzConjecture` is a `Prop`. It is not among the 19 theorems. `collatz_orbit_seven` and `reachesOne_seven` are the ordinary trajectory of 7. They do not prove the conjecture.

Author: Benjamin Stanley Frohman, ORCID 0009-0006-7068-3718.

## Rebuild

```sh
git clone https://github.com/BenFrohman/CollatzConjecture.git
cd CollatzConjecture
lake build
python3 certificates/tools/sorry_scan.py
python3 certificates/tools/gen_audit.py /tmp/KernelCertificateAudit.lean /tmp/modules.txt
lake env lean /tmp/KernelCertificateAudit.lean > /tmp/axioms.raw.txt
python3 certificates/tools/check_audit.py /tmp/axioms.raw.txt
```
