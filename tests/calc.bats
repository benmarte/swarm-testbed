#!/usr/bin/env bats

@test "add: 3 + 4 = 7" {
  run bash calc.sh add 3 4
  [ "$status" -eq 0 ]
  [ "$output" = "7" ]
}

@test "mul: 3 * 4 = 12" {
  run bash calc.sh mul 3 4
  [ "$status" -eq 0 ]
  [ "$output" = "12" ]
}
