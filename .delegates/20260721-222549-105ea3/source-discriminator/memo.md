Memo — source discriminator

- Best live route: independent semantic review of the compiled interface. This is now the cheapest decisive step: the repaired target build passed, so another local build is only a control, not a new discriminator.

- Sourced status: [Erdős Problems #530](https://www.erdosproblems.com/530) currently marks the problem open/not finitely decidable, gives the exact ℓ(N) and “ℓ(N) ∼ N¹ᐟ²?” wording, and says “Formalised statement? No.” It also warns its literature coverage may be incomplete. The [May 2026 Bailleul–Riblet preprint](https://arxiv.org/abs/2605.03181) improves the lower-bound constant to \(1/(3\sqrt3)\) for arbitrary finite subsets of \(\mathbb R^d\), but does not establish the conjectured asymptotic.

- Reported computation: the fixed candidate [530.lean](/root/proof-factory/research/scout-bdf77f43574b/workspace/FormalConjectures/ErdosProblems/530.lean) (SHA-256 `208af82a…71c9`) passed the exact `lake --wfail` target driver, exit 0, empty stderr, and emitted a 126,000-byte OLean (`5401908c…3201`). The durable run log is [experiment.json](/root/proof-factory/research/scout-bdf77f43574b/workspace/lab-runs/lab-scout-bdf77f43574b-83c018dc57aa/segment-000001/20260721-220709-5122ed/experiment.json).

- Cheapest discriminator: give a Formal Conjectures reviewer only the official page and the candidate, asking whether all four meanings reconstruct exactly:
  1. Sidon allows repeated summands and identifies swapped pairs.
  2. `GuaranteedSidonSize` uses exact cardinality.
  3. `ell` is the bounded maximum guaranteed size.
  4. the final theorem represents precisely the “in particular” asymptotic question.
  
  First discrepancy rejects/redirects the interface; no discrepancy advances it to clean-checkout/full-CI.

- Controls: do not repeat the ruled-out weak-Sidon or ordered-pair encodings. Existing 512-subset regression already distinguishes them; `{0,1,2}` must fail, while swapping `(a,b)` must be trivial. The passed target driver [run_erdos530_lean_build.sh](/root/proof-factory/research/scout-bdf77f43574b/workspace/checks/run_erdos530_lean_build.sh) is a compilation control only.

- Failure modes: reviewer may reject the “exactly k” convention, require definitions in `FormalConjecturesForMathlib`, or flag the source’s broader “determine the order” request as omitted. The latter is intentional only if maintainers accept the scoped “in particular” declaration.

- Reusable artifact: source hash, warning-fatal driver, OLean hash, and reviewer checklist; no larger search is justified. The best safe reduction remains the exact module target, excluding 8,037 unrelated targets.

- Outside acceptance path: [issue #773](https://github.com/google-deepmind/formal-conjectures/issues/773) is open and unassigned. A contributor with authority must satisfy the project’s CLA, submit a PR linked to that issue, pass full `lake build`, and obtain review; the project explicitly requires PR review and permits bespoke definitions with API tests ([contribution guide](https://github.com/google-deepmind/formal-conjectures/blob/main/CONTRIBUTING.md)).

Sol should independently verify the reviewer’s reading against the source and the full-build/PR gates, and reject any claim that the local OLean, finite regression, or preprint proves the conjecture or constitutes upstream acceptance.
