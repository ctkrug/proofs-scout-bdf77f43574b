Memo — source discriminator

- Best live route: repair the single control lemma, then rerun the hash-locked exact target build. The maintained page still marks #530 **open**, asks the exact extremal question, and says it is **not formalised**. It was last edited 8 April 2026. [Source](https://www.erdosproblems.com/530)

- Exact rationale: the refactored candidate’s 625-second `--wfail` target build reached only one error: line 102’s `IsSidon` arguments are in the wrong order. Project `IsSidon` takes membership arguments in the order `i₁, j₁, i₂, j₂`, while its sum is `i₁ + i₂ = j₁ + j₂`. The current call encodes the wrong equality; the independent Lean audit already contains the correct collision ordering `0, 1, 2, 1`. This is an elaboration/control-test defect, not evidence against the source statement or API reuse.

- Cheapest discriminator: run the existing independent audit (`checks/Erdos530SemanticAudit.lean`, previously kernel-checked in 10.082 s) after making the control lemma match its argument ordering. It must still establish:
  1. legacy finite predicate iff project `IsSidon` for every `Finset ℝ`;
  2. `{0,1,2}` is rejected via `0+2=1+1`;
  3. swaps remain permitted.
  
  If that passes, update the candidate/check-out byte hashes and run `checks/run_erdos530_lean_build.sh`. Require exit 0, no warnings, and a nonempty hashed `530.olean`. Do not reuse the prior pre-refactor OLean.

- Controls and failure modes:
  - Keep the global equivalence theorem; do not substitute another finite enumeration.
  - Preserve repeated-summand and commutative-swap controls—these exclude weak-Sidon and ordered-pair-uniqueness misstatements.
  - A new build failure outside this control lemma redirects to its first diagnostic; no full CI yet.
  - No large search is warranted. The safe reduction is one semantic audit (~10 s) before the cached exact target (~626 s observed); the target still has an 8,038-job dependency closure, so it must not be described as eliminating 8,037 jobs.

- Reusable artifact: `checks/Erdos530SemanticAudit.lean` plus the hash-locking build driver. They give future contributors a kernel-checked semantic regression against the shared API.

- Outside acceptance path: issue #773 is open, unassigned, and has no linked branch/PR. [Issue #773](https://github.com/google-deepmind/formal-conjectures/issues/773) The repository guide requires needed definitions/results in a separate `FormalConjecturesForMathlib` file, indexing that file, a project build, CLA, and a PR linked to the issue. Thus placement of `GuaranteedSidonSize`, `ell`, and their lemmas is the next maintainer decision after compilation.

- Stop condition: stop this route if the repaired audit or exact target gives a new first failure, or if maintainers reject the helper-definition placement.

Sol should independently verify the argument-order repair against `Basic.lean`, the new source/checkout/OLean hashes, and whether the extremal helpers must move to `FormalConjecturesForMathlib`; it should reject any claim of proof, upstream acceptance, or formalisation completion.
