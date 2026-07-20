# Erdős Problem #530 — baseline audit

Audit timestamp: 2026-07-20 UTC. This is a baseline/status document, not a solution claim.

## Exact target and current status

The maintained source asks: for each `N`, let `ell(N)` be the largest `k` such that every
`N`-element finite subset of `ℝ` contains a `k`-element Sidon subset, where the only solutions
to `a + b = c + d` are those with the same unordered pair of summands. Determine the order of
`ell(N)`; specifically, is `ell(N) ~ sqrt(N)`?

As accessed on 2026-07-20, the page is marked **OPEN**, says “Formalised statement? No”, was last
edited 2026-04-08, and warns that this status is the site owner's belief rather than a complete
literature certification. Formal Conjectures issue #773 is open, unassigned, “up for grabs”, and
shows no linked branch or pull request.

The contribution scoped here is only a correct Lean interface: a Sidon predicate, a bounded
extremal function, its elementary maximality API, and the explicit asymptotic question. It must
not claim a proof of the conjecture or formalize only the already-known `Theta(sqrt N)` result.

## Historical and current method map

- The maintained page attributes the original question to Riddell (1969), records the earlier
  lower bound `ell(N) ≫ N^(1/3)`, and notes the interval upper bound
  `ell(N) ≤ (1 + o(1)) sqrt(N)` by taking `A = {1,...,N}`.
- Komlós–Sulyok–Szemerédi (1975), *Linear problems in combinatorial number theory*, obtained
  `ell(N) ≫ sqrt(N)`, fixing the exponent but not the conjectured leading constant.
- Abbott (1990), *Sidon Sets*, studies the same min-max function for integer sets. Its abstract
  states `g(n) > c sqrt(n)` for every `c < 2/25`. The 2026 preprint below describes the prior
  constant as `0.0805`; this numerical discrepancy is preserved as unresolved until the proofs,
  not only abstracts, are compared.
- Alon–Erdős (1985) proposed the stronger partition conjecture that every `N`-element ambient set
  is a union of at most `(1 + o(1)) sqrt(N)` Sidon sets. That would imply a large Sidon class by
  averaging, but it is stronger than Problem #530 and is not the formal target.
- Bailleul–Riblet, arXiv:2605.03181v1 (submitted 2026-05-04), is the closest current work found.
  It proves a lower bound `(1/(3 sqrt 3) + o(1)) sqrt(n)` for arbitrary finite integer sets and
  extends it uniformly to finite subsets of `ℝ^d`. Its mechanism is a large subset with an
  injective Freiman 2-morphism into a cyclic group, followed by Singer's covering; projection and
  Dirichlet approximation preserve the Sidon equation over `ℝ^d`. It improves the known constant
  but does not reach 1, so it does not settle `ell(N) ~ sqrt(N)`.
- Ma–Tang, arXiv:2602.23282, solves a related problem only when the ambient set is weak Sidon and
  treats a `(4,5)` local-difference variant. It is nearby terminology, not a solution of #530.

## Formalization choices and adversarial audit

1. `IsSidon` quantifies over four elements of a `Finset ℝ`, permits repeated summands, and regards
   swapped pairs as trivial. The controls `∅`, a singleton, and `{0,1,2}` distinguish this from
   two common misstatements: weak Sidon (which ignores doubles) and ordered-pair uniqueness (which
   incorrectly rejects swaps).
2. `GuaranteedSidonSize N k` uses exact cardinality, matching the source. The hereditary nature of
   the Sidon property makes smaller sizes available, but the extremal definition does not need to
   assume that theorem: `Nat.findGreatest ... N` searches only the justified bound `k ≤ N`.
3. `ell N` is bounded by construction. Supporting lemmas establish that `ell N` is guaranteed and
   is at least every other guaranteed `k`; this closes the semantic gap that an unqualified `sSup`
   definition could leave.
4. The asymptotic is stated with Mathlib's `~[atTop]` relation between the real-valued functions
   `N ↦ ell N` and `N ↦ Real.sqrt N`. This is closer to the mathematical symbol `~` than encoding
   only `Theta`. Because the source asks “is it true”, repository style calls for
   `answer(sorry) ↔ ...`.
5. Scope limits: no Lean build has yet been completed. The execution environment has Lean 4.32.0
   but no Mathlib checkout, while the repository currently pins Lean 4.27.0 and Mathlib commit
   `a3a10db0e9d66acbebf76c5e6a135066525ac900`. Shell network access cannot resolve GitHub, so the
   candidate remains unvalidated until built in a network-enabled checkout at the pinned versions.
   The first two capped Lean diagnostics aborted while creating a thread at 256 MB and 2048 MB;
   with `LEAN_NUM_THREADS=1` and 4096 MB, Lean reached the decisive setup error: unknown module
   prefix `FormalConjectures`. These resource failures are controls, not evidence about the file.

## Reusable software, verification tooling, and compute scale

- Candidate: `FormalConjectures/ErdosProblems/530.lean`.
- Independent semantic checker: `checks/check_sidon_semantics.py`; it compares a literal
  four-variable encoding with unordered-pair sum uniqueness on every subset of `[-4,4]` and runs
  adversarial controls. This checks only the stated finite domain and does not elaborate Lean.
- Required decisive verification: `lake build FormalConjectures.ErdosProblems.530`, then full
  `lake build`, at the repository-pinned toolchain and manifest; inspect output for `sorry` only in
  the open conjecture body and require repository CI plus human review of statement equivalence.
- Expected compute is small: dependency retrieval dominates; isolated elaboration should take
  seconds and a full cached repository build minutes, not a cloud search.

## Acceptance path

Comment on Formal Conjectures issue #773 to request assignment, sign the Google CLA, create the
source-appropriate `FormalConjectures/ErdosProblems/530.lean`, build locally, and submit a linked
pull request. Acceptance requires repository CI and maintainer review; a local or model-only check
is not external validation. Also notify the Erdős Problems page of the May 2026 lower-bound paper,
because it postdates the last page edit, but do not change the problem's open tag based only on this
audit.

## First technical experiment and stop condition

Hypothesis: the proposed four-variable Sidon predicate agrees with unique unordered sums with
repetition, while the weak and ordered-pair misencodings fail the chosen controls. Decisive signal:
zero mismatches on all 512 subsets of `[-4,4]`, all controls true. Stop this baseline experiment at
that finite domain; increasing the cutoff is not a contribution. Redirect next to pinned Lean
elaboration, because only the kernel/build can validate the actual declaration.

## Direct sources and searches

- https://www.erdosproblems.com/530
- https://www.erdosproblems.com/latex/530
- https://doi.org/10.1007/BF01895954
- https://doi.org/10.4153/CMB-1990-056-6
- https://arxiv.org/abs/2605.03181
- https://arxiv.org/abs/2602.23282
- https://github.com/google-deepmind/formal-conjectures/issues/773
- https://github.com/google-deepmind/formal-conjectures/blob/main/CONTRIBUTING.md
- https://github.com/google-deepmind/formal-conjectures/tree/main/FormalConjectures/ErdosProblems
- https://leanprover-community.github.io/mathlib4_docs/Mathlib/Data/Nat/Find.html
- https://leanprover-community.github.io/mathlib4_docs/Mathlib/Analysis/Asymptotics/AsymptoticEquivalent.html

Search trail (2026-07-20): web searches for exact title/statement, “largest Sidon subset arbitrary
finite set”, Abbott's constant, KSS DOI, 2026 Sidon subset literature, Formal Conjectures issue 773,
repository `IsEquivalent` examples, and Mathlib `Nat.findGreatest`. No prior formalization of #530
was found; this is status evidence, not proof of absence.
