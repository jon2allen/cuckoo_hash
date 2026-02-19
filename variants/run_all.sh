#!/bin/bash

echo "Compiling and Running Cuckoo Hashing Variants..."
echo "==============================================="

# Already in variants directory

# Compile all
gcc -O3 original.c -o original
gcc -O3 dary.c -o dary
gcc -O3 stash.c -o stash
gcc -O3 blocked.c -o blocked

# Run and collect results
./original
./dary
./stash
./blocked

echo "==============================================="
echo "Consolidated Report Done."
