## Goal

Add a `pow` operation to `calc.sh` that computes exponentiation, including fractional exponents (e.g., square roots), using only bash builtins. The script must remain dependency-free — no external commands like `bc`, `awk`, `python`, `perl`, or `expr`.

## Acceptance Criteria

1. `./calc.sh pow 2 5` prints `32`.
2. `./calc.sh pow 3 3` prints `27`.
3. `./calc.sh pow 2 0.5` prints exactly `1.4142135623730951`.
4. No external command is invoked — bash builtins only.
5. Existing `add`/`sub`/`mul`/`div` behaviour and tests are unchanged.

## Files Likely to Change

| File | Change |
|------|--------|
| `calc.sh` | Add `pow` case in the main switch/if block; implement exponentiation using bash arithmetic and fractional exponent approximation (e.g., Newton's method for square roots). |
| `test/calc_test.sh` (if exists) | Add test cases for `pow` with integer and fractional exponents. |

## Out of Scope

- Adding any external dependencies.
- Supporting negative exponents or complex numbers.
- Changing the existing `add`/`sub`/`mul`/`div` implementations.
- Performance optimizations beyond correctness.

## Branch Name

`feat/issue-5-pow-operation`

## PR Target

`main`
