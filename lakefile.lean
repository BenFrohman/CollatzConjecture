import Lake
open Lake DSL

package «collatz-statement» where
  leanOptions := #[
    ⟨`pp.unicode.fun, true⟩,
    ⟨`autoImplicit, false⟩,
    ⟨`relaxedAutoImplicit, false⟩
  ]

@[default_target]
lean_lib CollatzStatement where
  roots := #[`CollatzConjecture, `Collatz, `CollatzArgument]
