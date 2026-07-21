# Continuation checkpoint — Erdős #530 formalization

Last completed model epoch: discovery run 3, 2026-07-21 UTC.

## Durable baseline

- The maintained source is <https://www.erdosproblems.com/530>; the contribution is a precise
  open-conjecture interface, not a proof.
- The finite semantic control in `.proof-experiments/20260720-194758-ee6344` found exact agreement
  between two Sidon encodings on all 512 subsets of `{-4,…,4}`. Do not increase this arbitrary
  cutoff without a new semantic ambiguity.
- The checked-out Formal Conjectures base commit is
  `8f6e745798379104379da0b5c28c25315489890f`, with Lean 4.27.0 and Lake 5.0.0.
- The candidate is `FormalConjectures/ErdosProblems/530.lean`, now SHA-256
  `208af82a29f35bf60d55f86669f7794cf30aae39d71eb24968f255b8cfa771c9`.

## Run 3 discriminator and result

Predeclared hypothesis: the byte-identical candidate is warning-clean under a fresh warning-fatal
Lean elaboration. The direct experiment `.proof-experiments/20260721-215649-a0ba4b` timed out at
300.133 seconds with no stdout or stderr (exit 124, peak 785776 KiB). It is a bounded negative
performance result, not a source validation.

The completed lab `lab-scout-bdf77f43574b-3d017ba39303` supplied the decisive source discrepancy.
Lean elaborated the module and wrote a nonempty 125680-byte `530.olean`, but `lake --wfail` exited 1
after 837 seconds because eight supporting declarations had `category` attributes without AMS
metadata. The exact warnings are in
`lab-runs/lab-scout-bdf77f43574b-3d017ba39303/segment-000001/20260721-213642-26c8a7/stderr.txt`.
Thus the original candidate hash `50f308…ef6e4` is ruled out as warning-clean.

The validated cache-control lab `lab-scout-bdf77f43574b-bb1dc5fdc331` exited 0 in 23.018 seconds and
printed `Algebra.FiniteType`; it establishes that the pinned FiniteType OLean is readable. It does
not validate the conjecture module.

## Repair made

Added `AMS 5 11` to the five `category API` and three `category test` declarations. This is a
metadata-only repair; definitions, theorem statements, and proofs are unchanged. The workspace and
upstream checkout copies are byte-identical at the new candidate hash. Exactly two intended `sorry`
tokens remain, both in `erdos_530`.

The independent regression `.proof-experiments/20260721-220438-8cb4aa` exited 0 in 0.123 seconds:
both Sidon encodings again agreed on all 512 subsets, all seven boundary/negative controls passed,
and stderr was empty. This guards the unchanged semantics only; it is not a Lean kernel check.

The build driver `checks/run_erdos530_lean_build.sh` is SHA-256
`4280849bf03b69bfde4bffee04c171d962e109030a65a5924d0c920add0ea765`. It now fails closed unless
the two candidate copies are byte-identical and match the fixed repaired hash, runs the exact
warning-fatal numeric target, requires a nonempty OLean, and hashes that artifact.

## Repaired-target lab queued

- Job: `lab-scout-bdf77f43574b-83c018dc57aa`
- Queue spec: `lab-queue/lab-scout-bdf77f43574b-83c018dc57aa.json`
- Submission record:
  `records/labs/lab-scout-bdf77f43574b-83c018dc57aa-submitted-segment-01.json`
- Bound: one 1200-second segment, 16384 MB, one Lean thread, deterministic seed 0.
- Efficiency report: `experiments/erdos530-repaired-target-efficiency.json`.

Queueing is not evidence. Do not claim that the repaired candidate builds until the completed record,
stdout, stderr, hashes, and nonempty OLean check are inspected.

## Exact first action next epoch

Inspect the durable state for `lab-scout-bdf77f43574b-83c018dc57aa` without resubmitting. If exit 0,
verify the logged checkout/source/OLean hashes and absence of warning output, then record one
`lab_review` validation. If it fails, preserve and repair only the first exact warning or elaboration
discrepancy.

After a validated target pass, run a clean-checkout application/build control and then a checkpointed
full `lake --wfail build`. Do not run either interactively if expected to exceed two minutes.

## Remaining contribution gates

1. Repaired target build passes and produces a nonempty `530.olean`.
2. A clean checkout with only the candidate applied reproduces the target check.
3. Full repository `lake --wfail build` and repository CI pass.
4. A human Formal Conjectures reviewer checks repeated summands, swapped-pair triviality, exact-size
   versus at-least-size, bounded maximality, and `~[atTop]` with `Real.sqrt`.
5. A linked pull request for issue #773 is accepted; no external publication was authorized here.

Stop at the first discrepancy. Do not attempt to prove the open conjecture or claim upstream
formalization before maintainer acceptance.
