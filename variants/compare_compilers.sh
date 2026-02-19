#!/bin/bash

# Define variants to test
variants=("original" "dary" "stash" "blocked")

echo "Compiling and Benchmarking with GCC vs CCC..."
echo "=========================================================================================="
printf "%-25s | %-12s | %-12s | %-12s | %-8s\n" "Variant" "Compiler" "Avg Time (s)" "Load Factor" "Disp"
echo "------------------------------------------------------------------------------------------"

for var in "${variants[@]}"; do
    # 1. Benchmark GCC
    gcc -O3 "$var.c" -o "${var}_gcc" 2>/dev/null
    res_gcc=$(./"${var}_gcc")
    # Extract values using regex or basic formatting
    time_gcc=$(echo "$res_gcc" | grep -oP "AvgTime=\K[0-9.]+")
    lf_gcc=$(echo "$res_gcc" | grep -oP "AvgLF=\K[0-9.]+")
    disp_gcc=$(echo "$res_gcc" | grep -oP "AvgDisp=\K[0-9.]+")
    printf "%-25s | %-12s | %-12s | %-12s | %-8s\n" "$var" "GCC" "$time_gcc" "$lf_gcc" "$disp_gcc"

    # 2. Benchmark CCC
    ccc -O3 "$var.c" -o "${var}_ccc" 2>/dev/null
    res_ccc=$(./"${var}_ccc")
    time_ccc=$(echo "$res_ccc" | grep -oP "AvgTime=\K[0-9.]+")
    lf_ccc=$(echo "$res_ccc" | grep -oP "AvgLF=\K[0-9.]+")
    disp_ccc=$(echo "$res_ccc" | grep -oP "AvgDisp=\K[0-9.]+")
    printf "%-25s | %-12s | %-12s | %-12s | %-8s\n" "" "CCC" "$time_ccc" "$lf_ccc" "$disp_ccc"
    echo "------------------------------------------------------------------------------------------"
done

echo "Benchmark Complete."
