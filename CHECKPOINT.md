# Continuation checkpoint — Erdős #530 formalization

Last completed epoch: discovery run 2, 2026-07-21 UTC.

## Established before this run

- The source/status baseline and post-page-update literature audit are in
  `research/baseline_audit.md`.
- The candidate is `FormalConjectures/ErdosProblems/530.lean`, SHA-256
  `50f3081d7647c1a892356043e55a96d8720aeea6ba64cfc89754fa79da4ef6e4`.
- The two independent finite Sidon encodings agreed on all 512 subsets of
  `{-4,...,4}`. Do not increase this arbitrary cutoff without a new semantic ambiguity.
- A prior interactive direct elaboration at pinned Lean 4.27.0 was reported successful, but this
  run did not find a corresponding immutable experiment record. It therefore remains useful
  diagnostic history, not completion of the reproducibility contract.

## Run 2 discriminator and exact observations

Hypothesis: the candidate builds as a warning-fatal Formal Conjectures module at the pinned
toolchain. Success required a zero exit from the repository build entry point. Any target-resolution,
dependency, warning, or elaboration error was the predeclared failure signal.

Three recorded attempts failed before Lean read the candidate body:

1. `.proof-experiments/20260721-184217-5689de`: the checkpoint's old bare target
   `FormalConjectures.ErdosProblems.530` failed in 34.675 s with Lake's empty-path
   `no such file or directory` (exit 1; peak child memory 514492 KiB).
2. `.proof-experiments/20260721-184333-13112b`: with `--dir`, the relative source-path target
   `FormalConjectures/ErdosProblems/530.lean` failed in 106.924 s as `unknown module source path`
   (exit 1; peak 449152 KiB). `--dir` did not rebase that CLI path as assumed.
3. `.proof-experiments/20260721-184835-cc1cd3`: a direct warning-fatal elaboration against the
   bootstrap cache failed in 33.114 s because `FormalConjecturesUtil.olean` did not yet exist
   (exit 1; peak 527652 KiB). The mandated bootstrap process was still compiling that target after
   the tool call yielded; it was interrupted after exceeding the two-minute uncheckpointed-work
   threshold. This is a dependency-race result, not a Lean source error.

Lake 5.0.0's own `lake help build` gives the correct disambiguated module form; the successful
0.122-second documentation control is `.proof-experiments/20260721-185548-c3172e`. Numeric Lean
module components need guillemets, so the target is:

```text
+FormalConjectures.ErdosProblems.«530»
```

Do not retry either failed addressing form. An attempted matched query on existing numeric module
`+FormalConjectures.ErdosProblems.«1»` was stopped after 135 seconds because it was rebuilding local
dependencies outside the checkpointed lab; it produced no result and is not evidence.

## Checkpointed lab job now queued

- Job: `lab-scout-bdf77f43574b-eec7321621e3`
- Submission record:
  `records/labs/lab-scout-bdf77f43574b-eec7321621e3-submitted-segment-01.json`
- Queue spec: `lab-queue/lab-scout-bdf77f43574b-eec7321621e3.json`
- Driver: `checks/run_erdos530_lean_build.sh`, SHA-256
  `dbdeb901c19808cb9f06785e269b79690ba7b5cfe368db7e655077015a2ff6c2`
- Bound: one 1200-second segment, 1100 MB, deterministic seed 0.
- Exact action: record the workspace and checkout candidate hashes, record checkout commit and Lake
  version, then run `lake --wfail build '+FormalConjectures.ErdosProblems.«530»'` with one Lean
  thread.

Queueing is not evidence. Do not claim that this build passed until the completed lab record and
logs are inspected.

## Exact first action next epoch

Inspect, without resubmitting, the job's records:

```text
find records/labs -maxdepth 1 -type f \
  -name 'lab-scout-bdf77f43574b-eec7321621e3*' -print
```

If the completed segment exits zero and the two hashes match, promote the local target build to an
independently reproducible kernel check. Then submit a separate checkpointed `lake --wfail build`
for the full repository; do not run it interactively because dependency rebuilding exceeded two
minutes here. If the segment fails, preserve and address only the first dependency, warning, or
elaboration discrepancy. Do not attempt the open conjecture.

## Remaining acceptance gates

1. Correct target build passes and produces the `530` OLean.
2. Full `lake --wfail build` passes.
3. Exactly the two intended `sorry` occurrences remain, both in the open conjecture declaration
   (`answer(sorry)` and its proof).
4. A human Formal Conjectures reviewer checks repeated summands, swapped-pair triviality,
   exact-size versus at-least-size, bounded maximality, and `~[atTop]` with `Real.sqrt`.
5. Repository CI passes. A local build, Git commit, Sol review, or Terra memo is not external
   validation.

Stop successfully only after all five gates. The live bottleneck is the queued correct-target build,
followed by full build and human semantic review.
