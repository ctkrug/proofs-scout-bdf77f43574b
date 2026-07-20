# Continuation checkpoint — Erdős #530 formalization

Last completed epoch: baseline audit, 2026-07-20 UTC.

## What is established

- The official statement/status and Formal Conjectures issue #773 were audited.
- The post-page-update Bailleul–Riblet paper arXiv:2605.03181 is closest current work; it improves
  the lower-bound constant but does not settle the conjectured asymptotic constant 1.
- A candidate Lean file and a finite independent semantic checker are in the workspace.
- Terra memo provenance was verified: SHA-256
  `a84aafb6c27cf9ae1dc1e0820d1ddf60ea350d8dff9dd334f9e6c52fcbdcb3af`.

## Current blocker

This environment cannot resolve GitHub from the shell. It has Lean 4.32.0 but no Mathlib checkout;
Formal Conjectures main pins Lean 4.27.0 and Mathlib
`a3a10db0e9d66acbebf76c5e6a135066525ac900`. Therefore the candidate has not been elaborated and
must not be called a completed formalization.

The successful setup diagnostic is `.proof-experiments/20260720-194925-0f2242`: with
`LEAN_NUM_THREADS=1` it records the unknown `FormalConjectures` module prefix. Earlier diagnostics
`20260720-194849-f1733c` and `20260720-194914-3f029d` are failed resource controls (“failed to create
thread”) and must not be interpreted as source errors.

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
