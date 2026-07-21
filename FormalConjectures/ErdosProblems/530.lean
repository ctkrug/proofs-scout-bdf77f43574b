/-
Copyright 2026 The Formal Conjectures Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    https://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-/

import FormalConjecturesUtil

/-!
# Erdős Problem 530

*References:*

- [erdosproblems.com/530](https://www.erdosproblems.com/530)
- [Ri69] Riddell, J., On sets of numbers containing no l terms in arithmetic progression.
  Nieuw Arch. Wisk. (3) (1969), 204--209.
- [KSS75] Komlós, J. and Sulyok, M. and Szemerédi, E., Linear problems in combinatorial number
  theory. Acta Math. Acad. Sci. Hungar. 26 (1975), 113--121.
- [AlEr85] Alon, N. and Erdős, P., An application of graph theory to additive number theory.
  European J. Combin. 6 (1985), 201--203.

The theorem below formalizes the explicit “in particular” question on the maintained problem
page. It does not formalize a particular choice of answer to that open question.
-/

open Filter
open scoped Asymptotics

namespace Erdos530

/-- A finite set is Sidon when equality of two pairwise sums forces equality of the
corresponding unordered pairs. Repetition of a summand is allowed. -/
def IsSidon (S : Finset ℝ) : Prop :=
  ∀ a ∈ S, ∀ b ∈ S, ∀ c ∈ S, ∀ d ∈ S,
    a + b = c + d → (a = c ∧ b = d) ∨ (a = d ∧ b = c)

/-- `GuaranteedSidonSize N k` means that every `N`-element finite set of reals contains an
exactly `k`-element Sidon subset. -/
def GuaranteedSidonSize (N k : ℕ) : Prop :=
  ∀ A : Finset ℝ, A.card = N →
    ∃ S : Finset ℝ, S ⊆ A ∧ S.card = k ∧ IsSidon S

/-- Every finite set has the empty Sidon subset. -/
@[category API, AMS 5 11]
theorem guaranteedSidonSize_zero (N : ℕ) : GuaranteedSidonSize N 0 := by
  intro A hA
  exact ⟨∅, by simp [IsSidon]⟩

/-- A guaranteed subset size cannot exceed the size of its ambient set. -/
@[category API, AMS 5 11]
theorem GuaranteedSidonSize.le {N k : ℕ} (h : GuaranteedSidonSize N k) : k ≤ N := by
  classical
  obtain ⟨A, hA⟩ := Finset.exists_card_eq (α := ℝ) N
  obtain ⟨S, hSA, hSk, _⟩ := h A hA
  calc
    k = S.card := hSk.symm
    _ ≤ A.card := Finset.card_le_card hSA
    _ = N := hA

/-- The largest size that is guaranteed for every `N`-element finite set of reals. -/
noncomputable def ell (N : ℕ) : ℕ :=
  by
    classical
    exact Nat.findGreatest (GuaranteedSidonSize N) N

/-- The extremal function is bounded by the ambient cardinality. -/
@[category API, AMS 5 11]
theorem ell_le (N : ℕ) : ell N ≤ N := by
  classical
  exact Nat.findGreatest_le N

/-- The value selected by `ell` is itself guaranteed. -/
@[category API, AMS 5 11]
theorem guaranteedSidonSize_ell (N : ℕ) : GuaranteedSidonSize N (ell N) := by
  classical
  exact Nat.findGreatest_spec (Nat.zero_le N) (guaranteedSidonSize_zero N)

/-- Every guaranteed size is at most `ell N`. -/
@[category API, AMS 5 11]
theorem GuaranteedSidonSize.le_ell {N k : ℕ} (h : GuaranteedSidonSize N k) : k ≤ ell N := by
  classical
  exact Nat.le_findGreatest h.le h

/-- The empty set is Sidon. -/
@[category test, AMS 5 11]
theorem isSidon_empty : IsSidon (∅ : Finset ℝ) := by
  simp [IsSidon]

/-- Every singleton is Sidon. -/
@[category test, AMS 5 11]
theorem isSidon_singleton (x : ℝ) : IsSidon {x} := by
  simp [IsSidon]

/-- The set `{0, 1, 2}` is not Sidon because `0 + 2 = 1 + 1`. -/
@[category test, AMS 5 11]
theorem not_isSidon_zero_one_two : ¬ IsSidon ({0, 1, 2} : Finset ℝ) := by
  intro h
  have h' := h 0 (by simp) 2 (by simp) 1 (by simp) 1 (by simp) (by norm_num)
  norm_num at h'

/--
Let $\ell(N)$ be maximal such that in any finite set $A\subset \mathbb{R}$ of size $N$ there
exists a Sidon subset $S$ of size $\ell(N)$ (i.e. the only solutions to $a+b=c+d$ in $S$ are
the trivial ones). Determine the order of $\ell(N)$.

In particular, is it true that $\ell(N)\sim N^{1/2}$?
-/
@[category research open, AMS 5 11]
theorem erdos_530 :
    answer(sorry) ↔
      (fun N : ℕ ↦ (ell N : ℝ)) ~[atTop] (fun N : ℕ ↦ Real.sqrt N) := by
  sorry

end Erdos530
