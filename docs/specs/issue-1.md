# Fix `sub` Command in calc.sh

## Goal

Fix the `sub` command in `calc.sh` so it correctly computes the difference between two numbers instead of their sum. Currently, `./calc.sh sub 5 3` outputs `8` (the sum) instead of `2` (the difference). A regression test must be added to prevent this bug from recurring.

## Acceptance Criteria

1. `./calc.sh sub 5 3` outputs `2`
2. `./calc.sh sub 10 4` outputs `6`
3. `./calc.sh sub 3 5` outputs `-2` (correctly handles negative results)
4. `./calc.sh sub 0 0` outputs `0`
5. A regression test exists that verifies the `sub` command returns the correct difference for at least two test cases
6. All other existing commands (`add`, `mul`, `div`, etc.) continue to work correctly
7. The regression test passes when run as part of the test suite

## Files Likely to Change

| File | Description |
|------|-------------|
| `calc.sh` | Fix the subtraction logic in the `sub` command handler |
| `tests/test_calc.sh` (or equivalent test file) | Add regression test(s) for the `sub` command |

## Out of Scope

- Adding new commands to `calc.sh`
- Refactoring the overall structure of `calc.sh`
- Input validation improvements beyond what's needed to fix this bug
- Documentation updates

## Branch Name

`feat/issue-1-fix-sub-command`

## PR Target

`main`
