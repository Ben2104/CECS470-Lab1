#!/usr/bin/env bash
set -euo pipefail

css="$(dirname "$0")/ch07-proj1.css"

require() {
  local description="$1"
  local pattern="$2"
  if rg -U -q "$pattern" "$css"; then
    printf 'PASS: %s\n' "$description"
  else
    printf 'FAIL: %s\n' "$description" >&2
    exit 1
  fi
}

require 'header uses flex and edge alignment' 'header \{[^}]*display: flex;[^}]*justify-content: space-between;[^}]*align-items: center;'
require 'desktop cards use 24 percent width' '\.card \{[^}]*width: 24%;'
require 'container and card collection use flexbox' '\.container \{[^}]*display: flex;[^}]*align-items: center;[^}]*justify-content: center;' 
require 'card collection distributes cards' '\.cards \{[^}]*display: flex;[^}]*justify-content: space-between;'
require 'images scale inside cards' 'img \{[^}]*max-width: 100%;'
require 'cover hover uses saturation' '\.card img:hover \{[^}]*filter: saturate\(150%\);'
require 'card hover uses drop shadow' '\.card:hover \{[^}]*box-shadow:'
require 'button fades in over one second' '\.card button \{[^}]*opacity: 0;[^}]*transition: opacity 1s;'
require 'mobile cards use full width' '@media only screen and \(max-width: 480px\)[\s\S]*?\.card \{[^}]*width: 100%;'
require 'tablet cards use 45 percent width' '@media only screen and \(min-width: 481px\)[\s\S]*?max-width: 768px[\s\S]*?\.card \{[^}]*width: 45%;'

printf 'All assignment checks passed.\n'
