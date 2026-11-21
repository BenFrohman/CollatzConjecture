/-
Collatz statement.

`CollatzConjecture` is the classical conjecture: every positive natural number
reaches 1 under the map `n ↦ n/2` if even and `n ↦ 3n+1` if odd.

This file does not prove that statement. `reachesOne_pow_two` proves only that
every power of two reaches 1. The Hodge conjecture is a different statement
and is not encoded here.
-/

def collatzStep (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

/-- Apply `f` exactly `k` times, starting from `n`. -/
def iterate (f : Nat → Nat) : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => iterate f k (f n)

def reachesOne (n : Nat) : Prop :=
  ∃ k : Nat, iterate collatzStep k n = 1

/-- The Collatz conjecture, stated as in `CollatzConjecture.lean`. This is a `Prop`, not a theorem. -/
def CollatzConjecture : Prop :=
  ∀ n : Nat, 0 < n → ∃ k : Nat, iterate collatzStep k n = 1

theorem collatzStep_two_mul (m : Nat) : collatzStep (2 * m) = m := by
  unfold collatzStep
  have h : (2 * m) % 2 = 0 := Nat.mul_mod_right 2 m
  simp [h, Nat.mul_div_cancel_left m (by decide : 0 < 2)]

/-- Powers of two reach 1. This is not `CollatzConjecture`.

Step 0. `2 ^ 0 = 1`. Zero iterations leave the input unchanged, so `iterate collatzStep 0 1 = 1`.

Step 1. Assume `2 ^ k` reaches 1 in `n` steps.

Step 2. `2 ^ (k + 1) = 2 * 2 ^ k` by `Nat.pow_succ`.

Step 3. `collatzStep (2 * 2 ^ k) = 2 ^ k` by `collatzStep_two_mul`, because `2 * m` is even and division by 2 cancels the factor.

Step 4. One more iteration sends `2 ^ (k + 1)` to `2 ^ k`, and the induction hypothesis finishes the remaining `n` steps.
-/
theorem reachesOne_pow_two (k : Nat) : reachesOne (2 ^ k) := by
  induction k with
  | zero =>
    exact ⟨0, rfl⟩
  | succ k ih =>
    obtain ⟨n, hn⟩ := ih
    refine ⟨n + 1, ?_⟩
    rw [iterate]
    rw [show 2 ^ (k + 1) = 2 * 2 ^ k by rw [Nat.pow_succ, Nat.mul_comm]]
    rw [collatzStep_two_mul]
    exact hn

#print axioms collatzStep_two_mul
#print axioms reachesOne_pow_two
