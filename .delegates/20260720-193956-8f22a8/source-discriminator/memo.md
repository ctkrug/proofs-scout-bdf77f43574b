Memo — source discriminator for Erdős #530

**Source/status (sourced).** The official entry is [Erdős Problems #530](https://www.erdosproblems.com/530): **OPEN**, last edited 8 Apr 2026, with “Formalised statement? No.” It states exactly: for finite \(A\subset\mathbb R\) of cardinality \(N\), let \(\ell(N)\) be the maximal guaranteed Sidon-subset size; ask for its order, in particular \(\ell(N)\sim\sqrt N\). It reports \(N^{1/2}\ll\ell(N)\le(1+o(1))N^{1/2}\), with unknown constant, and warns that the status is the site owner’s belief. The cited source text and bibliography are at [the LaTeX source](https://www.erdosproblems.com/latex/530).

**Best live route (proposal).** Submit only a scoped Lean statement, not any claimed bound:

- `IsSidon (S : Finset ℝ)`: every `a+b=c+d` with all four terms in `S` yields `(a=c ∧ b=d) ∨ (a=d ∧ b=c)`.
- `GuaranteedSidonSize N k`: every `A : Finset ℝ` with `A.card = N` contains `S ⊆ A` with `S.card = k` and `IsSidon S`.
- Define `ell N` using `Nat.findGreatest (GuaranteedSidonSize N) N`, under `classical`. This is preferable to an unqualified `sSup`: it is bounded by construction and directly represents the largest possible size once the elementary maximality API is supplied.
- State the binary “in particular” clause as  
  `answer(sorry) ↔ Tendsto (fun N : ℕ ↦ (ell N : ℝ) / √(N : ℝ)) atTop (𝓝 1)`.

This preserves the intended \(\sim\) while making its type/coercions explicit.

**Cheapest executable discriminator.** In an up-to-date checkout of `google-deepmind/formal-conjectures`, add `FormalConjectures/ErdosProblems/530.lean`, then run:

```bash
lake build FormalConjectures.ErdosProblems.530
lake build
```

The file should use namespace `Erdos530`, theorem `erdos_530`, and attributes `@[category research open, AMS 5 11]`. The project’s [Erdős-specific rules](https://github.com/google-deepmind/formal-conjectures/tree/main/FormalConjectures/ErdosProblems) require that naming; its [contribution guide](https://github.com/google-deepmind/formal-conjectures/blob/main/CONTRIBUTING.md) requires a source-appropriate file, references, a build, issue, and reviewed PR.

**Controls.**

- Add API tests that `∅` and a singleton are Sidon, and that `{0,1,2}` is not (since \(0+2=1+1\)). This catches vacuous or overly weak predicates.
- Prove only the definitional scaffolding: `GuaranteedSidonSize N 0`, `GuaranteedSidonSize N k → k ≤ N`, and the two `findGreatest` maximality facts. These are not progress on the open asymptotic question.
- Keep “determine the order” in the docstring; do not silently replace it by a stronger exact-constant claim.

**Failure modes.**

- A predicate that permits nontrivial repeated-pair sums, or forbids the swapped pair, misstates “trivial.”
- Defining `ell` with `sSup` but omitting existence/boundedness lemmas leaves “largest” unjustified.
- Encoding only \(\Theta(\sqrt N)\) loses the site’s stated conjecture \(\ell(N)\sim\sqrt N\).
- Treat the official open tag as a literature-complete certification; it explicitly is not.

**Reusable artifact / acceptance path.** The reusable deliverable is a single reviewed `530.lean` plus tiny API tests, accepted externally by a Formal Conjectures issue/PR after Google CLA and CI/reviewer approval. The target repository explicitly welcomes Erdős Problems statements and requires human review for formalization accuracy.

**Stop condition.** Stop after the scoped file elaborates, the controls pass, full `lake build` passes, and a reviewer confirms the Sidon predicate and asymptotic translation. Do not pursue a proof or promote a resolution.

**What Sol should independently verify.** Confirm the literature/status beyond the website; review whether `answer(sorry)` is preferred for this “is it true” subquestion; and inspect the exact semantics of `Nat.findGreatest` maximality before accepting `ell` as the intended largest function.
