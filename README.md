# Collatz conjecture

This repository states the Collatz conjecture as a Lean 4 proposition. It does not prove it.

Toolchain: `leanprover/lean4:v4.30.0-rc1`.

## Official statement

`CollatzConjecture` in `CollatzConjecture.lean` has type `Prop`:

For every natural number `n` with `0 < n`, there exists a natural number `k` such that applying the Collatz step `k` times to `n` yields `1`. The step sends an even number to `n / 2` and an odd number to `3 * n + 1`.

```lean
def CollatzConjecture : Prop :=
  ∀ n : Nat, 0 < n → ∃ k : Nat, iterate collatzStep k n = 1
```

Check the declaration with `lean CollatzConjecture.lean`. The output of `#check CollatzConjecture` is `CollatzConjecture : Prop`.

## What else typechecks

`CollatzArgument.lean` proves that this proposition is equivalent to every positive natural number eventually hitting a power of two, proves the two-step odd branch `(3 * n + 1) / 2`, proves that every power of two reaches `1`, and proves that `3` reaches `1`. `#print axioms` on those theorems lists `propext` or no axioms. None of them has type `CollatzConjecture`.

Author: Benjamin Stanley Frohman.
