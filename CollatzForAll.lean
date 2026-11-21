/-
The Collatz conjecture for every positive natural number.

This is the sentence called `RemainingLemma` in
`BenFrohman/collatz-teaming-lemma`, file `CollatzTeaming/ReverseTree.lean`.
It is stated here under its own name. It is a `Prop`. It is not a theorem.
-/

def T (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

def iter (k n : Nat) : Nat :=
  match k with
  | 0 => n
  | k + 1 => T (iter k n)

/-- The Collatz conjecture for all positive natural numbers:
some iterate of `T` equals `1`. -/
def CollatzForAll : Prop :=
  ∀ n : Nat, 0 < n → ∃ k : Nat, iter k n = 1
