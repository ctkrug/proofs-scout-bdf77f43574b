# Continuation checkpoint — Erdős #530 formalization

Last completed model epoch: discovery run 4 continuation, 2026-07-22 UTC.

## Durable baseline

- The maintained source is <https://www.erdosproblems.com/530>. It states the exact-cardinality
  extremal function and asks in particular whether `ell(N) ~ sqrt(N)`; it marks the problem open
  and not formalised. The contribution is a statement interface, not a proof.
- Formal Conjectures issue <https://github.com/google-deepmind/formal-conjectures/issues/773> is open,
  unassigned, and has no linked branch or pull request as of this epoch.
- The pinned source checkout for the completed target build was commit
  `8f6e745798379104379da0b5c28c25315489890f`, Lean 4.27.0, Lake 5.0.0.
- The finite control `.proof-experiments/20260720-194758-ee6344` compared two independent Sidon
  encodings on all 512 subsets of `{-4,...,4}`. Do not enlarge that arbitrary domain without a new
  ambiguity.

## Run 4 completed-lab review

Validated lab `lab-scout-bdf77f43574b-83c018dc57aa` for the pre-refactor source hash
`208af82a29f35bf60d55f86669f7794cf30aae39d71eb24968f255b8cfa771c9`:

- durable record:
  `records/labs/lab-scout-bdf77f43574b-83c018dc57aa-completed-awaiting-review-segment-01.json`;
- runner record:
  `lab-runs/lab-scout-bdf77f43574b-83c018dc57aa/segment-000001/20260721-220709-5122ed/experiment.json`;
- return code 0 after 886.529 seconds, empty stderr, peak child memory 2,711,332 KiB;
- exact target output: `Built FormalConjectures.ErdosProblems.«530»`, 8038/8038 jobs;
- OLean: 126000 bytes, SHA-256
  `5401908c387930bccf42f4582f47d45c63085d71d2d6ef6ea4dee725db5a3201`.

This validates only the warning-fatal target build of the pre-refactor candidate. It is not a
semantic review, full repository build, CI result, or upstream acceptance.

## Run 4 discriminator and result

The repository already exports `IsSidon` from
`FormalConjecturesForMathlib/Combinatorics/Basic.lean`, so the candidate's namespace-local finite-set
definition duplicated an existing API. The cheapest discriminator was a separately compiled Lean
equivalence theorem, not another finite cutoff.

`checks/Erdos530SemanticAudit.lean` (SHA-256
`d9766dd56de50bc1617d545147436aaf18a0992a118931efda65cc3f621f5bf9`) restates the removed predicate
as `LegacyFinsetIsSidon` and proves it equivalent for every finite set of reals to the project
set-level `IsSidon`. It also checks the repeated-summand collision `{0,1,2}` and the swapped-pair
clause. Experiment `.proof-experiments/20260721-223233-e53846` exited 0 in 10.082 seconds with empty
stdout and stderr under Lean 4.27.0. This is a global definitional-semantics result, not a finite
sample.

Two failed setup attempts are preserved:

- `.proof-experiments/20260721-222914-f94e3f` failed before theorem elaboration because an imported
  target OLean referenced a stale mounted cache path;
- `.proof-experiments/20260721-223142-8e7b27` reached the checker but rejected repository-specific
  category attributes because the isolated import intentionally omitted `FormalConjecturesUtil`.

The required project bootstrap was run successfully. Removing the irrelevant attributes produced
the decisive clean checker result.

## API refactor and control repair

`FormalConjectures/ErdosProblems/530.lean` reuses project `IsSidon (S : Set ℝ)` and removes the
duplicate local definition. Lab `lab-scout-bdf77f43574b-03d1a8ffc4cf` reached the refactored source
after 625.802 seconds and failed only at the `{0,1,2}` adversarial control. The candidate had supplied
arguments in the removed legacy predicate's order. The pinned project definition takes membership
arguments `(i₁, j₁, i₂, j₂)` and compares `i₁ + i₂ = j₁ + j₂`, so the collision call must be
`(0,1,2,1)`, not `(0,2,1,1)`.

That one line was repaired. The workspace and pinned-checkout copies are byte-identical at SHA-256
`3ff7038c3c08f48408f48d53c4503182944cfd8c51b549cbab570a3b062e8466`. The extremal definitions,
bounded-maximum lemmas, and asymptotic declaration are unchanged. The build driver is hash-locked to
this source and has SHA-256
`ea7486e083994d8727f76eef3d928a584c8a325f241a1ad962382fca4b5789a1`.

The independent semantic audit source was unchanged at SHA-256
`d9766dd56de50bc1617d545147436aaf18a0992a118931efda65cc3f621f5bf9`; its prior kernel pass remains
the semantic evidence. A new bounded retry, `.proof-experiments/20260722-043421-7797b3`, timed out at
120.135 seconds with empty stdout/stderr and return code 124. Treat this only as a cold/resource timing
result. It neither validates nor falsifies the repair, and it must not be retried locally now that its
measured duration exceeds the two-minute lab threshold.

The repaired refactored source has not yet been kernel-checked as a target. Do not reuse the old
pre-refactor OLean for this hash.

## Repaired-target lab queued

- Job: `lab-scout-bdf77f43574b-135f90912547`.
- Queue spec: `lab-queue/lab-scout-bdf77f43574b-135f90912547.json` (mutable navigation only; never
  claim it in `evidence_files`).
- Bound: one 1200-second segment, 16384 MB, one Lean thread, deterministic seed 0.
- Candidate SHA-256: `3ff7038c3c08f48408f48d53c4503182944cfd8c51b549cbab570a3b062e8466`.
- Driver SHA-256: `ea7486e083994d8727f76eef3d928a584c8a325f241a1ad962382fca4b5789a1`.
- Efficiency report: `experiments/erdos530-project-api-refactor-efficiency.json`.

Queueing is not evidence. The defensible efficiency statement remains: one named module is requested
instead of every project root, but its target log still has an 8038-job dependency closure and the
exact reduction relative to a full build is unmeasured.

As of 2026-07-22, GitHub issue #773 remains open and unassigned. The current repository contribution
guide says definitions/results needed to formulate a conjecture belong in a separate
`FormalConjecturesForMathlib` file and must be indexed. Therefore the present helper placement is not
yet acceptance-ready even if this target build passes.

## Exact first action next epoch

Inspect durable state for `lab-scout-bdf77f43574b-135f90912547` without resubmitting. If complete,
check the immutable lab record and content-addressed runner output, exact source/driver hashes,
stdout, stderr, and nonempty OLean hash, then issue exactly one lab-review decision. Redirect on the
first warning or elaboration discrepancy.

If the repaired target passes, move `GuaranteedSidonSize`, `ell`, and reusable proved API lemmas to a
separate appropriately indexed `FormalConjecturesForMathlib` file, leaving the open declaration and
problem-specific tests in `FormalConjectures/ErdosProblems/530.lean`. Rebuild the exact target before
requesting a clean-checkout target and checkpointed full `lake --wfail build`.

## Remaining contribution gates

1. The repaired refactored exact target builds warning-clean and emits a nonempty OLean.
2. Supporting definitions/results are moved and indexed as required by the repository guide, and a
   maintainer-style review accepts the exact-size convention, bounded maximum, project API reuse,
   asymptotic declaration, and final placement.
3. A clean checkout with only the proposed patch reproduces the target build.
4. Full repository `lake --wfail build` and repository CI pass.
5. A linked pull request for issue #773 is accepted after the contributor satisfies the CLA.

Do not claim a proof of the conjecture or an upstream formalization before maintainer acceptance.
