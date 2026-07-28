#!/usr/bin/env bash
set -euo pipefail

op="${1:-}"
a="${2:-}"
b="${3:-}"

INT_MAX=9223372036854775807

die() { printf 'calc.sh: %s\n' "$1" >&2; exit 1; }

# base^n for non-negative integers, guarded against 64-bit overflow.
ipow() {
  local base=$1 n=$2 r=1
  if (( base == 0 && n > 0 )); then
    printf '0'
    return
  fi
  if (( base <= 1 )); then
    printf '1'
    return
  fi
  while (( n > 0 )); do
    if (( r > INT_MAX / base )); then
      die 'pow: result exceeds 64-bit integer range'
    fi
    r=$(( r * base ))
    n=$(( n - 1 ))
  done
  printf '%s' "$r"
}

# Round-to-nearest double sqrt of a 64-bit integer N, printed as the shortest
# decimal that re-parses to the same double. Digit-by-digit binary square
# root, streamed 2 bits per step so no intermediate exceeds ~58 bits; builds
# 55 result bits (53-bit mantissa + 2 guard bits) and uses the remainder as
# the sticky bit for rounding. Perfect squares print as plain integers.
fsqrt() {
  local N=$1
  if (( N == 0 )); then
    printf '0'
    return
  fi
  local L=0 t=$N
  while (( t > 0 )); do
    L=$(( L + 1 ))
    t=$(( t >> 1 ))
  done
  local pairs=$(( (L + 1) / 2 )) root=0 rem=0 i d trial
  for (( i = 0; i < 55; i++ )); do
    if (( i < pairs )); then
      d=$(( (N >> (2 * (pairs - i - 1))) & 3 ))
    else
      d=0
    fi
    rem=$(( (rem << 2) | d ))
    trial=$(( (root << 2) | 1 ))
    if (( trial <= rem )); then
      rem=$(( rem - trial ))
      root=$(( (root << 1) | 1 ))
    else
      root=$(( root << 1 ))
    fi
  done
  local k=$(( 55 - pairs ))   # sqrt(N) == root / 2^k, root has 55 bits
  if (( rem == 0 && (root & ((1 << k) - 1)) == 0 )); then
    printf '%s' $(( root >> k ))
    return
  fi
  local m=$(( root >> 2 )) low=$(( root & 3 )) e=$(( 2 - k ))
  if (( low > 2 || (low == 2 && rem > 0) )); then
    m=$(( m + 1 ))
  fi
  if (( m >> 53 )); then
    m=$(( m >> 1 ))
    e=$(( e + 1 ))
  fi
  # value == m * 2^e exactly; the builtin printf parses the hex-float literal
  # and does the binary->decimal conversion. Shortest precision that survives
  # a round-trip through %.17g is the canonical repr (matches python/printf).
  local hex fp canon p s back
  printf -v hex '%x' "$m"
  fp="0x${hex}p${e}"
  printf -v canon '%.17g' "$fp"
  s=$canon
  for (( p = 1; p <= 17; p++ )); do
    printf -v s '%.*g' "$p" "$fp"
    printf -v back '%.17g' "$s"
    if [[ $back == "$canon" ]]; then
      break
    fi
  done
  printf '%s' "$s"
}

# pow <base> <exponent>: exponent may be an integer or end in .5 (square
# roots): base^(n+0.5) == sqrt(base^(2n+1)). Negative operands unsupported.
pow_op() {
  local base=$1 exp=$2 int frac
  local base_re='^[0-9]+$' exp_re='^([0-9]+)(\.([0-9]+))?$'
  [[ $base =~ $base_re ]] || die 'pow: base must be a non-negative integer'
  [[ $exp =~ $exp_re ]] || die 'pow: exponent must be a non-negative number'
  int=${BASH_REMATCH[1]}
  frac=${BASH_REMATCH[3]:-}
  while [[ $frac == *0 ]]; do frac=${frac%0}; done
  if (( ${#base} > 18 || ${#int} > 18 )); then
    die 'pow: operand too large'
  fi
  base=$(( 10#$base ))
  int=$(( 10#$int ))
  local N
  case "$frac" in
    '')
      N=$(ipow "$base" "$int")
      printf '%s\n' "$N"
      ;;
    5)
      N=$(ipow "$base" $(( 2 * int + 1 )))
      fsqrt "$N"
      printf '\n'
      ;;
    *)
      die 'pow: only integer and .5 fractional exponents are supported'
      ;;
  esac
}

case "$op" in
  add) echo $((a + b)) ;;
  sub) echo $((a - b)) ;;
  mul) echo $((a * b)) ;;
  pow) pow_op "$a" "$b" ;;
  *) printf 'usage: calc.sh <add|sub|mul|pow> <a> <b>\n' >&2; exit 1 ;;
esac
