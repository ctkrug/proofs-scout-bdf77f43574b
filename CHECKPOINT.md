# Continuation checkpoint — Erdős #530 formalization

Last completed epoch: baseline audit, 2026-07-20 UTC.

## What is established

- The official statement/status and Formal Conjectures issue #773 were audited.
- The post-page-update Bailleul–Riblet paper arXiv:2605.03181 is closest current work; it improves
  the lower-bound constant but does not settle the conjectured asymptotic constant 1.
- A candidate Lean file and a finite independent semantic checker are in the workspace.
- Terra memo provenance was verified: SHA-256
  `a84aafb6c27cf9ae1dc1e0820d1ddf60ea350d8dff9dd334f9e6c52fcbdcb3af`.

## Current state

The environment blocker was resolved on 2026-07-20: a project-scoped `elan` installation selected the
repository-pinned Lean 4.27.0 toolchain, and Formal Conjectures plus its pinned Mathlib revision were
fetched successfully. The candidate was updated for the repository's current import API:
`FormalConjecturesUtil` replaces the removed `FormalConjectures.Util.ProblemImports` module.

A direct elaboration against the pinned Lean and Mathlib environment completed without diagnostics.
The full repository-standard import build is still required before calling this a completed
formalization; it must also be run with `LEAN_NUM_THREADS=1` in memory-constrained environments.
The earlier diagnostics `20260720-194849-f1733c` and `20260720-194914-3f029d` are failed resource
controls (“failed to create thread”), not source errors.

## Exact first action next epoch

In a network-enabled workspace, clone current `google-deepmind/formal-conjectures`, copy
`FormalConjectures/ErdosProblems/530.lean` into it, preserve the repository's toolchain/manifest,
then run through the experiment wrapper:

```text
python3 /root/proof-factory/skills/computational-researcher/scripts/run_experiment.py \
  --name erdos530-lean-build \
  --hypothesis 'The scoped definitions, API controls, and asymptotic declaration elaborate at the repository-pinned versions' \
  --expected-signal 'Target build and full lake build exit 0; only the open conjecture body contains sorry' \
  --timeout 1800 --memory-mb 4096 \
  --source-url https://www.erdosproblems.com/530 \
  -- lake build FormalConjectures.ErdosProblems.530
```

If the target build passes, run full `lake build`, inspect every `sorry` occurrence in the new file,
and request human review of: (i) repeated summands, (ii) swapped-pair triviality, (iii) exact-size
guarantee versus at-least-size, and (iv) `~[atTop]` with `Real.sqrt`.

Stop when the target and full builds pass and issue/PR review confirms statement equivalence. If
the candidate fails, fix only elaboration/API issues; do not attempt the open conjecture.
