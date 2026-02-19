import sys
import re

def parse_output(content):
    # Search for lines like: Original Cuckoo: AvgTime=0.00001420, AvgLF=0.4975, AvgDisp=308.00
    pattern = r"([^:]+): AvgTime=([0-9.]+), AvgLF=([0-9.]+), AvgDisp=([0-9.]+)"
    results = []
    
    for line in content.splitlines():
        match = re.search(pattern, line)
        if match:
            results.append({
                "variant": match.group(1).strip(),
                "time": float(match.group(2)),
                "lf": float(match.group(3)),
                "disp": float(match.group(4))
            })
    return results

def print_report(gcc_results, ccc_results):
    print("\n" + "="*85)
    print(" CUCKOO HASHING PERFORMANCE REPORT (GCC vs CCC)")
    print("="*85)
    
    header = f"{'Variant':<25} | {'Comp':<5} | {'Time (s)':<12} | {'Load Factor':<12} | {'Disp':<8}"
    print(header)
    print("-" * len(header))
    
    # Store results in map for easy comparison
    ccc_map = {res['variant']: res for res in ccc_results}
    
    for g in gcc_results:
        var = g['variant']
        c = ccc_map.get(var)
        
        # GCC Line
        print(f"{var:<25} | {'GCC':<5} | {g['time']:<12.8f} | {g['lf']:<12.4f} | {g['disp']:<8.2f}")
        
        # CCC Line
        if c:
            speedup = c['time'] / g['time'] if g['time'] > 0 else 0
            print(f"{'':<25} | {'CCC':<5} | {c['time']:<12.8f} | {c['lf']:<12.4f} | {c['disp']:<8.2f} (GCC is {speedup:.1f}x faster)")
        
        print("-" * len(header))

if __name__ == "__main__":
    if len(sys.argv) < 3:
        print("Usage: python3 report.py 'gcc_output_string' 'ccc_output_string'")
        sys.exit(1)
        
    gcc_data = parse_output(sys.argv[1])
    ccc_data = parse_output(sys.argv[2])
    
    print_report(gcc_data, ccc_data)
