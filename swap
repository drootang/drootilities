#!/bin/bash --noprofile

# Swap 2 files

[[ ${#@} == 2 ]] || (echo "Provide exactly 2 arguments" 2>&1 && exit 1)

# Use local rename to ensure not moving between two volumes
tmp="$1.swap_$(date +%y%m%d-%H%M%S-%N)"
mv "$1" "$tmp" && mv "$2" "$1" && mv "$tmp" "$2"
