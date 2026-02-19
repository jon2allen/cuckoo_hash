#!/bin/bash

# Configuration
VARIANTS=("original" "dary" "stash" "blocked")
VAR_DIR="variants"

echo "=========================================================="
echo " Starting Cuckoo Hash Automation Suite"
echo "=========================================================="

# 1. Regenerate Data
echo "Step 1: Refreshing test data..."
python3 generate_csv.py

# 2. Compile and Run Benchmarks
cd "$VAR_DIR" || exit

echo "Step 2: Rebuilding executables and running benchmarks..."

GCC_OUT=""
CCC_OUT=""

for var in "${VARIANTS[@]}"; do
    # Compile with GCC
    gcc -O3 "$var.c" -o "${var}_gcc"
    out=$(./"${var}_gcc")
    GCC_OUT+="$out"$'\n'
    
    # Compile with CCC
    ccc -O3 "$var.c" -o "${var}_ccc"
    out=$(./"${var}_ccc")
    CCC_OUT+="$out"$'\n'
done

# 3. Generate Visual Report
echo "Step 3: Generating performance report..."
python3 report.py "$GCC_OUT" "$CCC_OUT"

echo "=========================================================="
echo " Process Complete"
echo "=========================================================="
