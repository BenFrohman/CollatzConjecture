# Collatz for all positive integers

`CollatzForAll` is included in the `main` build and in `certificates/CERTIFICATE.md`.

```lean
def CollatzForAll : Prop :=
  ∀ n : Nat, 0 < n → ∃ k : Nat, iter k n = 1
```

`T` sends an even number to `n / 2` and an odd number to `3 * n + 1`. `iter k n` applies `T` exactly `k` times.

This is the same sentence as `RemainingLemma` in `BenFrohman/collatz-teaming-lemma`. The 2026-11-21T22:28:10Z audit built this declaration. It is not one of the 19 theorems, because it has no proof.

Author: Benjamin Stanley Frohman.
