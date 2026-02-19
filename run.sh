#!/bin/bash

# Configuration
VARIANTS=("original" "dary" "stash" "blocked")
VAR_DIR="variants"
SKIP_CCC=false

# Check for flags
for arg in "$@"; do
    if [ "$arg" == "--no-ccc" ]; then
        SKIP_CCC=true
    fi
done

# Auto-detect CCC if not skipped
if [ "$SKIP_CCC" = false ]; then
    if ! command -v ccc &> /dev/null; then
        echo "Warning: 'ccc' compiler not found. Skipping CCC benchmarks."
        SKIP_CCC=true
    fi
fi

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
    echo "Benchmarking $var with GCC..."
    gcc -O3 "$var.c" -o "${var}_gcc"
    out=$(./"${var}_gcc")
    GCC_OUT+="$out"$'\n'
    
    # Compile with CCC if not skipped
    if [ "$SKIP_CCC" = false ]; then
        echo "Benchmarking $var with CCC..."
        ccc -O3 "$var.c" -o "${var}_ccc"
        out=$(./"${var}_ccc")
        CCC_OUT+="$out"$'\n'
    fi
done

# 3. Generate Visual Report
echo "Step 3: Generating performance report..."
python3 report.py "$GCC_OUT" "$CCC_OUT"

echo "=========================================================="
echo " Process Complete"
echo "=========================================================="
