# Continuation checkpoint — Erdős #530 formalization

Last completed model epoch: discovery run 4, 2026-07-21 UTC.

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

## API refactor made

`FormalConjectures/ErdosProblems/530.lean` now reuses project `IsSidon (S : Set ℝ)` and removes the
duplicate local definition. The workspace and checkout copies are byte-identical at SHA-256
`e27b8c80ed9edb57989006cc9bd299fdd58331c2b2a30b69ec9721b409562a2e`. The extremal definitions,
bounded-maximum lemmas, and asymptotic declaration are otherwise unchanged. The build driver is
hash-locked to this source and has SHA-256
`e2971cf312a830f1419729f45a817e60fbc7e7cceb9570b9dfa30aee825e8ec3`.

The refactored source has not yet been kernel-checked as a target. Do not reuse the old OLean claim
for the new hash.

## Refactored-target lab queued

- Job: `lab-scout-bdf77f43574b-03d1a8ffc4cf`.
- Submission record: `records/labs/lab-scout-bdf77f43574b-03d1a8ffc4cf-submitted-segment-01.json`.
- The queue item had been claimed and a run directory existed when this checkpoint was written, but
  there was not yet a completed record or `experiment.json`.
- Bound: one 1200-second segment, 16384 MB, one Lean thread, deterministic seed 0.
- Efficiency report: `experiments/erdos530-project-api-refactor-efficiency.json`.

Queueing is not evidence.

The submitted lab spec inherited an overstated delegate estimate that the exact module target
"excluded 8037 unrelated targets." Reject that count: the prior target log reports 8038 jobs in the
dependency closure, so those jobs were not eliminated. The workspace efficiency report now records
the defensible statement: one named project module is requested instead of every project root, but
the exact reduction relative to a full build is unmeasured. This correction does not affect the
source/hash prefilters or kernel-check design.

## Exact first action next epoch

Inspect durable state for `lab-scout-bdf77f43574b-03d1a8ffc4cf` without resubmitting. If complete,
check the record, stdout, stderr, source/driver hashes, and nonempty OLean hash, then issue one lab
review decision. If it fails, preserve and repair only the first warning or elaboration discrepancy.

If the refactored target passes, the next semantic discriminator is a maintainer-style placement
review: decide whether `GuaranteedSidonSize`, `ell`, and their API lemmas may remain scoped in the
problem file or must move to `FormalConjecturesForMathlib` under the contribution guide. Only after
that review should a clean-checkout target and checkpointed full `lake --wfail build` be run.

## Remaining contribution gates

1. The refactored exact target builds warning-clean and emits a nonempty OLean.
2. A maintainer-style review accepts the exact-size convention, bounded maximum, project API reuse,
   asymptotic declaration, and placement of supporting definitions.
3. A clean checkout with only the proposed patch reproduces the target build.
4. Full repository `lake --wfail build` and repository CI pass.
5. A linked pull request for issue #773 is accepted after the contributor satisfies the CLA.

Do not claim a proof of the conjecture or an upstream formalization before maintainer acceptance.
