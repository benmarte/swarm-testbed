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
