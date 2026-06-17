#!/bin/bash
# ============================================================
#  DEMO 2 — Cache Size Effect
#  Run from inside the cacti/ directory:
#  bash ../scripts/demo2_cachesize.sh
# ============================================================

CACTI=./cacti
CONFIGS=../demo_configs/demo2_cachesize
SEP="─────────────────────────────────────────────────────────"

echo ""
echo "╔═════════════════════════════════════════════════════════╗"
echo "║           DEMO 2 — Cache Size Effect                    ║"
echo "║   direct-mapped · 64B block · 45nm · 1 bank             ║"
echo "╚═════════════════════════════════════════════════════════╝"
echo ""
echo "  Concept: Bigger cache → more rows → longer column wire → slower"
echo ""
echo "  $SEP"
printf "  %-12s  %-14s  %-14s  %-14s\n" \
       "Cache Size" "Access (ns)" "Area (mm²)" "Leakage (mW)"
echo "  $SEP"

for cfg in $CONFIGS/size_128KB.cfg \
           $CONFIGS/size_256KB.cfg \
           $CONFIGS/size_512KB.cfg \
           $CONFIGS/size_1024KB.cfg; do

  size=$(grep "^-size" $cfg | awk '{print $3}')
  kb=$((size / 1024))
  out=$($CACTI -infile $cfg 2>/dev/null)

  access=$(echo "$out" | grep "Access time"          | head -1 | awk '{print $NF}')
  area=$(echo "$out"   | grep "Cache height x width" | head -1 | awk '{print $NF}')
  leak=$(echo "$out"   | grep "Total leakage power"  | head -1 | awk '{print $NF}')

  printf "  %-12s  %-14s  %-14s  %-14s\n" \
         "${kb}KB" "$access" "$area" "$leak"
done
