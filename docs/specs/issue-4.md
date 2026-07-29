## Goal

Add a `mod` operation to `calc.sh` that computes the remainder of integer division, printing the result to stdout. Division by zero must be handled gracefully (non-zero exit, error on stderr) instead of crashing with a bash arithmetic error. Existing operations (`add`, `sub`, `mul`, `div`) and their bats tests must remain unchanged.

## Acceptance Criteria

1. `./calc.sh mod 17 5` prints `2`.
2. `./calc.sh mod 9 3` prints `0`.
3. `./calc.sh mod 5 0` exits with a non-zero status and prints an error message on stderr (e.g., "Error: division by zero").
4. New bats tests in `tests/calc.bats` cover all three cases above.
5. The existing `add`/`sub`/`mul`/`div` behaviour and tests are unchanged.

## Files Likely to Change

| File | Change |
|------|--------|
| `calc.sh` | Add a `mod` case in the main switch/if block that performs `a % b` with a zero-division guard. |
| `tests/calc.bats` | Add three new test cases for `mod` (normal, zero remainder, division by zero). |

## Out of Scope

- No other arithmetic operations (e.g., `pow`, `sqrt`) are to be added.
- No changes to the existing `add`/`sub`/`mul`/`div` logic or their tests.
- No documentation or README updates required.

## Branch Name

`feat/issue-4-mod-operation`

## PR Target

`main`
