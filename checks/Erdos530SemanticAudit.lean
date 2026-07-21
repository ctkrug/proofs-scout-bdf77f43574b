/-
Independent semantic reconstruction for the Erdős Problem 530 interface.

This file deliberately restates the candidate's original finite-set Sidon predicate as
`LegacyFinsetIsSidon` and compares it with the reusable project definition `IsSidon`.
-/

import FormalConjecturesForMathlib.Combinatorics.Basic

namespace Erdos530SemanticAudit

/-- The literal finite-set predicate originally drafted in the Problem 530 candidate. -/
def LegacyFinsetIsSidon (S : Finset ℝ) : Prop :=
  ∀ a ∈ S, ∀ b ∈ S, ∀ c ∈ S, ∀ d ∈ S,
    a + b = c + d → (a = c ∧ b = d) ∨ (a = d ∧ b = c)

/-- The local draft and the repository's reusable set-level predicate have the same semantics. -/
theorem legacyFinsetIsSidon_iff_projectIsSidon (S : Finset ℝ) :
    LegacyFinsetIsSidon S ↔ IsSidon (S : Set ℝ) := by
  constructor
  · intro h i₁ hi₁ j₁ hj₁ i₂ hi₂ j₂ hj₂ hsum
    exact h i₁ hi₁ i₂ hi₂ j₁ hj₁ j₂ hj₂ hsum
  · intro h a ha b hb c hc d hd hsum
    exact h a ha c hc b hb d hd hsum

/-- The source's repeated-summand collision remains rejected by the project predicate. -/
theorem projectIsSidon_rejects_zero_one_two :
    ¬ IsSidon ({0, 1, 2} : Set ℝ) := by
  intro h
  have h' := h 0 (by simp) 1 (by simp) 2 (by simp) 1 (by simp) (by norm_num)
  norm_num at h'

/-- Exchanging the two summands is one of the explicitly permitted trivial representations. -/
theorem projectIsSidon_allows_swap_clause (a b : ℝ) :
    (a = b ∧ b = a) ∨ (a = a ∧ b = b) := by
  exact Or.inr ⟨rfl, rfl⟩

end Erdos530SemanticAudit
