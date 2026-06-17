#!/bin/bash
# ============================================================
#  DEMO 3b — Banking: Deep Dive (internal optimiser behaviour)
#  Run from inside the cacti/ directory:
#  bash ../scripts/demo3b_banking_deepdive.sh
# ============================================================

CACTI=./cacti
CONFIGS=../demo_configs/demo3b_banking_deepdive
SEP="────────────────────────────────────────────────────────────────────────────"

echo ""
echo "╔══════════════════════════════════════════════════════════════════════════╗"
echo "║             DEMO 3b — Banking: Deep Dive                                 ║"
echo "║     512KB · direct-mapped · 64B block · 45nm                             ║"
echo "╚══════════════════════════════════════════════════════════════════════════╝"
echo ""
echo "  CACTI doesn't just split the cache — it re-optimises the internal"
echo "  subarray layout (Ndwl × Ndbl) at every bank count."
echo "  Watch what happens to the layout as banks increase."
echo ""
echo "  $SEP"
printf "  %-8s  %-12s  %-8s  %-8s  %-8s  %-18s\n" \
       "Banks" "Access (ns)" "Ndwl" "Ndbl" "Nspd" "Phase"
echo "  $SEP"

prev_ndwl=""
prev_ndbl=""

for banks in 1 2 4 8 16 32 64; do
  cfg=$CONFIGS/banks_${banks}.cfg
  out=$($CACTI -infile $cfg 2>/dev/null)

  access=$(echo "$out" | grep "Access time"  | head -1 | awk '{print $NF}')
  ndwl=$(echo "$out"   | grep "Best Ndwl"    | head -1 | awk '{print $NF}')
  ndbl=$(echo "$out"   | grep "Best Ndbl"    | head -1 | awk '{print $NF}')
  nspd=$(echo "$out"   | grep "Best Nspd"    | head -1 | awk '{print $NF}')

  # Determine phase label
  phase=""
  if [ "$banks" -le 8 ]; then
    if [ -n "$prev_ndwl" ] && [ "$ndwl" != "$prev_ndwl" -o "$ndbl" != "$prev_ndbl" ]; then
      phase="← layout simplified"
    elif [ "$banks" -eq 1 ]; then
      phase="← baseline"
    elif [ "$banks" -eq 8 ]; then
      phase="← layout minimum"
    fi
  else
    nspd_lt1=$(echo "$nspd" | awk '{print ($1 < 1) ? "yes" : "no"}')
    if [ "$nspd_lt1" = "yes" ]; then
      phase="← Nspd fractional"
    else
      phase="← Ndwl/Ndbl stuck"
    fi
  fi

  printf "  %-8s  %-12s  %-8s  %-8s  %-8s  %-18s\n" \
         "$banks" "$access" "$ndwl" "$ndbl" "$nspd" "$phase"

  prev_ndwl=$ndwl
  prev_ndbl=$ndbl
done
