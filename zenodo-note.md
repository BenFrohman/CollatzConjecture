# A checked Collatz trajectory of 7, and three classical lemmas

Benjamin Stanley Frohman  
21 November 2026

This note records a Lean 4.30.0-rc1 build of `/Users/bb/collatz-statement`, published at https://github.com/BenFrohman/CollatzConjecture. `CollatzConjecture` is a `Prop`. It is not a theorem. No `sorryAx` appears in the axiom lists below.

## The odd step

`collatzStep n` is `n / 2` when `n` is even and `3 * n + 1` when `n` is odd.

## Trajectory of 7

`collatz_orbit_seven` proves each step. Five steps are the odd clause:

- `7 → 22` because `3 * 7 + 1 = 22`
- `22 → 11`
- `11 → 34` because `3 * 11 + 1 = 34`
- `34 → 17`
- `17 → 52` because `3 * 17 + 1 = 52`
- `52 → 26`
- `26 → 13`
- `13 → 40` because `3 * 13 + 1 = 40`
- `40 → 20`
- `20 → 10`
- `10 → 5`
- `5 → 16` because `3 * 5 + 1 = 16`
- `16 → 8 → 4 → 2 → 1`

`reachesOne_seven` proves that 16 iterations send 7 to 1. `#print axioms` reports that `collatz_orbit_seven` and `reachesOne_seven` depend on no axioms.

This is the ordinary trajectory of 7. It is not an undiscovered cycle, and it is not a proof that every positive integer reaches 1.

## The other checked conclusions

- `collatz_iff_hitsPowerOfTwo`: the conjecture is equivalent to every positive integer eventually hitting a power of two. Axiom: `propext`.
- `reachesOne_pow_two`: every `2 ^ k` reaches 1. Axiom: `propext`. The steps taken for `k ≥ 1` are halving. The odd clause remains part of `collatzStep`.
- `collatz_odd_two_step`: an odd `n` goes to `(3 * n + 1) / 2` in two steps. Axiom: `propext`.
- `reachesOne_three`: the trajectory of 3 reaches 1. No axioms.

`lake build` completed successfully under Lean `leanprover/lean4:v4.30.0-rc1`.
