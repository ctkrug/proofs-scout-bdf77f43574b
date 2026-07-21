Memo — source discriminator

Best live route: submit the byte-identical `530.lean` as a Formal Conjectures contribution, then run a checkpointed full `lake --wfail build` and request maintainer semantic review on issue #773.

Rationale: the maintained source still states exactly the proposed min–max problem, marks it OPEN and “Formalised statement? No.” [Erdős Problem #530](https://www.erdosproblems.com/530) The repository issue remains open, unassigned, and has no linked PR or branch. [Formal Conjectures #773](https://github.com/google-deepmind/formal-conjectures/issues/773) The May 2026 Bailleul–Riblet preprint improves the lower-bound constant but does not prove the conjectured asymptotic, so it is literature context, not a redirection. [arXiv:2605.03181](https://arxiv.org/abs/2605.03181)

Cheapest executable discriminator: fresh direct source elaboration, warning-fatal, at the pinned Lean toolchain, followed by the disambiguated Lake target:

```bash
LEAN_NUM_THREADS=1 lake --dir .upstream/formal-conjectures env lean \
  -DwarningAsError=true FormalConjectures/ErdosProblems/530.lean

LEAN_NUM_THREADS=1 lake --dir .upstream/formal-conjectures --wfail build \
  '+FormalConjectures.ErdosProblems.«530»'
```

Both exited 0 here (about 27 seconds and 26 seconds respectively) with candidate hash `50f308…ef6e4`, against Lean 4.27.0/Lake 5.0.0 and checkout `8f6e745…890f`. The direct elaboration is the meaningful source-body check; the Lake invocation may reuse the pre-existing `530.olean`, so it is not by itself evidence of a fresh compile.

Controls and failure modes:

- Retain the 512-case Sidon-encoding control; do not enlarge it without a new ambiguity.
- Reject weak-Sidon or ordered-pair encodings: `{0,1,2}` distinguishes the former; swapped summands distinguish the latter.
- The queued lab has no completed record—only its submission stub remains—so do not represent it as validated evidence.
- Local upstream status shows `530.lean` is untracked. A passing local build neither formalizes the problem upstream nor establishes source equivalence.

Reusable artifact: [`530.lean`](/root/proof-factory/research/scout-bdf77f43574b/workspace/FormalConjectures/ErdosProblems/530.lean) plus [`run_erdos530_lean_build.sh`](/root/proof-factory/research/scout-bdf77f43574b/workspace/checks/run_erdos530_lean_build.sh). The driver’s intended exact target and hash checks are correct.

Stop condition: stop the technical route at the first full-build, CI, or reviewer discrepancy. A positive result matters externally only after a linked PR for [#773](https://github.com/google-deepmind/formal-conjectures/issues/773), contributor/CLA completion, repository CI, and maintainer acceptance.

Sol should independently verify: a clean checkout build after applying the candidate; exactly two intended `sorry`s; repeated summands, swapped-pair triviality, exact cardinality/maximality, and the `~[atTop]`/`Real.sqrt` translation. Reject any claim that #530 is solved, already formalized upstream, or literature-completely settled.
