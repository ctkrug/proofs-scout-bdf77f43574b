# Lean formalization of Erdős Problem #530 (largest guaranteed Sidon subset)

This is the private, problem-scoped research repository maintained by Proof Factory.

## Problem

Add a scoped Lean declaration for: letting ℓ(N) be the largest k such that every finite A ⊆ ℝ with |A| = N has a Sidon subset S ⊆ A of size k, conjecturally ℓ(N) ~ √N. The contribution is the precise formal statement and supporting definitions, not a claimed proof.

Authoritative source: https://www.erdosproblems.com/530

## Repository contract

- `records/attempts/` contains immutable structured attempt records and readable write-ups.
- `records/research-state.json` is the latest compact memory of facts, exclusions, leads, and strategy state.
- `records/labs/` records submitted and completed simulation-lab segments.
- Code, proof files, checkers, notes, and bounded-search artifacts live beside those records.
- Generated files too large for ordinary Git are hash-manifested in `.proof-repository/LARGE_ARTIFACTS.json`.
- A commit records work; it does not establish correctness, novelty, or peer review.

AI assistance and computational tools are disclosed in each attempt record. Positive findings still
require independent verification, a novelty check, Charlie's approval, and external validation.
