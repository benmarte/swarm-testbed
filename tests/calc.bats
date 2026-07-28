#!/usr/bin/env bats

@test "add: 3 + 4 = 7" {
  run bash calc.sh add 3 4
  [ "$status" -eq 0 ]
  [ "$output" = "7" ]
}

@test "sub: 5 - 3 = 2" {
  run bash calc.sh sub 5 3
  [ "$status" -eq 0 ]
  [ "$output" = "2" ]
}

@test "sub: 10 - 4 = 6" {
  run bash calc.sh sub 10 4
  [ "$status" -eq 0 ]
  [ "$output" = "6" ]
}

@test "sub: 3 - 5 = -2" {
  run bash calc.sh sub 3 5
  [ "$status" -eq 0 ]
  [ "$output" = "-2" ]
}

@test "sub: 0 - 0 = 0" {
  run bash calc.sh sub 0 0
  [ "$status" -eq 0 ]
  [ "$output" = "0" ]
}

@test "mul: 3 * 4 = 12" {
  run bash calc.sh mul 3 4
  [ "$status" -eq 0 ]
  [ "$output" = "12" ]
}

@test "pow: 2 ^ 5 = 32" {
  run bash calc.sh pow 2 5
  [ "$status" -eq 0 ]
  [ "$output" = "32" ]
}

@test "pow: 3 ^ 3 = 27" {
  run bash calc.sh pow 3 3
  [ "$status" -eq 0 ]
  [ "$output" = "27" ]
}

@test "pow: 2 ^ 0 = 1" {
  run bash calc.sh pow 2 0
  [ "$status" -eq 0 ]
  [ "$output" = "1" ]
}

@test "pow: 2 ^ 0.5 = 1.4142135623730951" {
  run bash calc.sh pow 2 0.5
  [ "$status" -eq 0 ]
  [ "$output" = "1.4142135623730951" ]
}

@test "pow: 2 ^ 2.5 = 5.656854249492381" {
  run bash calc.sh pow 2 2.5
  [ "$status" -eq 0 ]
  [ "$output" = "5.656854249492381" ]
}

@test "pow: 10 ^ 0.5 = 3.1622776601683795" {
  run bash calc.sh pow 10 0.5
  [ "$status" -eq 0 ]
  [ "$output" = "3.1622776601683795" ]
}

@test "pow: 9 ^ 0.5 = 3 (perfect square prints an integer)" {
  run bash calc.sh pow 9 0.5
  [ "$status" -eq 0 ]
  [ "$output" = "3" ]
}

@test "pow: uses only bash builtins (runs with empty PATH)" {
  run bash -c 'PATH=""; "$BASH" calc.sh pow 2 0.5'
  [ "$status" -eq 0 ]
  [ "$output" = "1.4142135623730951" ]
}

@test "pow: unsupported fractional exponent fails" {
  run bash calc.sh pow 2 0.3
  [ "$status" -eq 1 ]
}

@test "pow: overflowing result fails cleanly" {
  run bash calc.sh pow 10 40
  [ "$status" -eq 1 ]
}
