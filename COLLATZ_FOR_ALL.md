# Collatz for all positive integers

`CollatzForAll` in `CollatzForAll.lean` is the sentence

```lean
def CollatzForAll : Prop :=
  ∀ n : Nat, 0 < n → ∃ k : Nat, iter k n = 1
```

`T` sends an even number to `n / 2` and an odd number to `3 * n + 1`. `iter k n` applies `T` exactly `k` times.

This is the same sentence as `RemainingLemma` in `BenFrohman/collatz-teaming-lemma`. `lean CollatzForAll.lean` under Lean 4.30.0-rc1 prints `CollatzForAll : Prop`. There is no theorem of this type in this branch.

Author: Benjamin Stanley Frohman.
