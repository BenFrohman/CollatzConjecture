# Collatz conjecture

Author: Benjamin Stanley Frohman &lt;frohmanbenjamin@gmail.com&gt;

This repository states the Collatz conjecture as a Lean 4 proposition. It does not prove it.

Zenodo note: [10.5281/zenodo.24429710](https://doi.org/10.5281/zenodo.24429710). The note records the trajectory of 7 and the classical lemmas. It does not prove the conjecture.

Toolchain: `leanprover/lean4:v4.30.0-rc1`, read from `lean-toolchain`. Elan selects that compiler when the commands below are run in this directory. Dependencies: none. `lakefile.lean` builds the three root modules with `autoImplicit` off.

## Official statement

`CollatzConjecture` in `CollatzConjecture.lean` has type `Prop`:

For every natural number `n` with `0 < n`, there exists a natural number `k` such that applying the Collatz step `k` times to `n` yields `1`. The step sends an even number to `n / 2` and an odd number to `3 * n + 1`.

```lean
def CollatzConjecture : Prop :=
  ∀ n : Nat, 0 < n → ∃ k : Nat, iterate collatzStep k n = 1
```

## Conclusions that typecheck

These are the conclusions of the finished theorems. None of them is `CollatzConjecture`.

- `collatz_iff_hitsPowerOfTwo` concludes that `CollatzConjecture` is equivalent to `∀ n, 0 < n → hitsPowerOfTwo n`. Hitting a power of two means some iterate equals `2 ^ m`. Axiom: `propext`.
- `reachesOne_pow_two` concludes that every `2 ^ k` reaches `1`. Axiom: `propext`.
- `collatz_odd_two_step` concludes that an odd `n`, after two steps, equals `(3 * n + 1) / 2`. Axiom: `propext`.
- `reachesOne_three` concludes that `3` reaches `1`. No axioms.
- `collatz_orbit_seven` concludes the 16 steps from `7` to `1`. Five of them are `3 * n + 1`: `7`, `11`, `17`, `13`, and `5`. No axioms. This is the ordinary trajectory of `7`, not a new cycle.
- `reachesOne_seven` concludes that `7` reaches `1` in 16 steps. No axioms.
- `hitsPowerOfTwo_of_reachesOne` concludes that reaching `1` means the same iterate equals `2 ^ 0`. No axioms.

`#print axioms` lists no `sorryAx`.

## Check

```sh
lake update
lake build
```

`lake build` elaborates the modules. A successful build does not make `CollatzConjecture` a theorem.

License: see `NOTICE`.
