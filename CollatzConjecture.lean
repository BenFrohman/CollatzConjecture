/-
Official statement of the Collatz conjecture.

Author: Benjamin Stanley Frohman
Toolchain: leanprover/lean4:v4.30.0-rc1

`CollatzConjecture` has type `Prop`. This file does not prove it.
-/

/-- The Collatz step. An even number goes to `n / 2`. An odd number goes to `3 * n + 1`. -/
def collatzStep (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

/-- The result of applying `f` exactly `k` times, starting at `n`. -/
def iterate (f : Nat → Nat) : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => iterate f k (f n)

/-- The Collatz conjecture.

For every natural number `n` with `0 < n`, there exists a natural number `k`
such that applying `collatzStep` exactly `k` times to `n` yields `1`.

This declaration is a `Prop`. It is not a theorem. -/
def CollatzConjecture : Prop :=
  ∀ n : Nat, 0 < n → ∃ k : Nat, iterate collatzStep k n = 1

#check CollatzConjecture
