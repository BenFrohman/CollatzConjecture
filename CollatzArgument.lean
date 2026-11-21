import CollatzConjecture

/-
The Collatz argument that can be built without assuming the conjecture.

`CollatzConjecture` stays a definition. The proved content is:

* one even step cancels a factor of two
* one odd step produces `3n + 1`, and the next step divides by two
* reaching 1 is equivalent to eventually hitting a power of two
* every power of two reaches 1
* the number 3 reaches 1, by a finite computation

The equivalent statement `∀ n, 0 < n → hitsPowerOfTwo n` is not proved.
-/

theorem iterate_add (f : Nat → Nat) (k j n : Nat) :
    iterate f (k + j) n = iterate f j (iterate f k n) := by
  induction k generalizing n with
  | zero =>
    simp [iterate, Nat.zero_add]
  | succ k ih =>
    rw [Nat.succ_add, iterate, ih, iterate]

theorem collatzStep_even (n : Nat) (h : n % 2 = 0) : collatzStep n = n / 2 := by
  simp [collatzStep, h]

theorem collatzStep_odd (n : Nat) (h : n % 2 = 1) : collatzStep n = 3 * n + 1 := by
  simp [collatzStep, h]

theorem collatzStep_two_mul (m : Nat) : collatzStep (2 * m) = m := by
  have h : (2 * m) % 2 = 0 := Nat.mul_mod_right 2 m
  rw [collatzStep_even _ h]
  exact Nat.mul_div_cancel_left m (by decide : 0 < 2)

theorem two_mul_mod_two (t : Nat) : (2 * t) % 2 = 0 :=
  Nat.mul_mod_right 2 t

/-- An odd input makes `3n + 1` even, and equal to `2 * (3 * (n / 2) + 2)`. -/
theorem odd_three_mul_succ_even (n : Nat) (h : n % 2 = 1) :
    3 * n + 1 = 2 * (3 * (n / 2) + 2) := by
  have hsplit : 2 * (n / 2) + n % 2 = n := by
    simpa [Nat.mul_comm] using Nat.div_add_mod n 2
  have hn : n = 2 * (n / 2) + 1 := by
    rw [h] at hsplit
    exact hsplit.symm
  let t := n / 2
  have ht : n = 2 * t + 1 := by
    simpa [t] using hn
  calc
    3 * n + 1 = 3 * (2 * t + 1) + 1 := by rw [ht]
    _ = 3 * (2 * t) + 3 * 1 + 1 := by rw [Nat.mul_add]
    _ = 3 * (2 * t) + 3 + 1 := by rw [Nat.mul_one]
    _ = 3 * (2 * t) + 4 := by rfl
    _ = 3 * 2 * t + 4 := by rw [← Nat.mul_assoc]
    _ = 6 * t + 4 := by rfl
    _ = 2 * 3 * t + 2 * 2 := by rfl
    _ = 2 * (3 * t) + 2 * 2 := by rw [Nat.mul_assoc]
    _ = 2 * (3 * t + 2) := by rw [← Nat.mul_add]

/-- The odd branch, two steps: `n ↦ (3n + 1) / 2`. -/
theorem collatz_odd_two_step (n : Nat) (h : n % 2 = 1) :
    iterate collatzStep 2 n = (3 * n + 1) / 2 := by
  rw [iterate, iterate]
  simp [iterate]
  rw [collatzStep_odd n h]
  have heq : 3 * n + 1 = 2 * (3 * (n / 2) + 2) := odd_three_mul_succ_even n h
  have he : (3 * n + 1) % 2 = 0 := by
    rw [heq]
    exact two_mul_mod_two (3 * (n / 2) + 2)
  rw [collatzStep_even _ he, heq]

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

theorem iterate_hits_reachesOne (n k m : Nat)
    (h : iterate collatzStep k n = 2 ^ m) : reachesOne n := by
  obtain ⟨j, hj⟩ := reachesOne_pow_two m
  refine ⟨k + j, ?_⟩
  rw [iterate_add]
  rw [h]
  exact hj

theorem reachesOne_of_hitsPowerOfTwo (n : Nat) (h : hitsPowerOfTwo n) : reachesOne n := by
  obtain ⟨k, m, hk⟩ := h
  exact iterate_hits_reachesOne n k m hk

theorem hitsPowerOfTwo_of_reachesOne (n : Nat) (h : reachesOne n) : hitsPowerOfTwo n := by
  obtain ⟨k, hk⟩ := h
  refine ⟨k, 0, ?_⟩
  -- `2 ^ 0` is definitionally `1`.
  exact hk

/-- Collatz is exactly the statement that every positive integer hits a power of two. -/
theorem collatz_iff_hitsPowerOfTwo :
    CollatzConjecture ↔ (∀ n : Nat, 0 < n → hitsPowerOfTwo n) := by
  constructor
  · intro h n hn
    exact hitsPowerOfTwo_of_reachesOne n (h n hn)
  · intro h n hn
    exact reachesOne_of_hitsPowerOfTwo n (h n hn)

/-- A finite odd orbit: `3 → 10 → 5 → 16 → 8 → 4 → 2 → 1`. -/
theorem reachesOne_three : reachesOne 3 :=
  ⟨7, rfl⟩

/-- The trajectory of `7`, a different start from `3`.
Five terms are odd, and each uses `3 * n + 1`:
`7 → 22`, `11 → 34`, `17 → 52`, `13 → 40`, `5 → 16`.
The rest are halving steps. The path joins the powers of two at `16` and ends at `1`.
This trajectory is the ordinary orbit of `7`. It is not an undiscovered cycle. -/
theorem collatz_orbit_seven :
    collatzStep 7 = 3 * 7 + 1 ∧
    collatzStep 22 = 11 ∧
    collatzStep 11 = 3 * 11 + 1 ∧
    collatzStep 34 = 17 ∧
    collatzStep 17 = 3 * 17 + 1 ∧
    collatzStep 52 = 26 ∧
    collatzStep 26 = 13 ∧
    collatzStep 13 = 3 * 13 + 1 ∧
    collatzStep 40 = 20 ∧
    collatzStep 20 = 10 ∧
    collatzStep 10 = 5 ∧
    collatzStep 5 = 3 * 5 + 1 ∧
    collatzStep 16 = 8 ∧
    collatzStep 8 = 4 ∧
    collatzStep 4 = 2 ∧
    collatzStep 2 = 1 := by
  decide

theorem reachesOne_seven : reachesOne 7 :=
  ⟨16, rfl⟩

