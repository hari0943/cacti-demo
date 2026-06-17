#!/bin/bash
# ============================================================
#  DEMO 1 — Block Size Effect
#  Run from inside the cacti/ directory:
#  bash ../scripts/demo1_blocksize.sh
# ============================================================

CACTI=./cacti
CONFIGS=../demo_configs/demo1_blocksize
SEP="─────────────────────────────────────────────────────────"

echo ""
echo "╔═════════════════════════════════════════════════════════╗"
echo "║           DEMO 1 — Block Size Effect                    ║"
echo "║   512KB · direct-mapped · 45nm · 1 bank                 ║"
echo "╚═════════════════════════════════════════════════════════╝"
echo ""
echo "  Concept: Smaller block → more tag bits → bigger tag array → slower"
echo ""
echo "  $SEP"
printf "  %-12s  %-14s  %-14s  %-14s\n" \
       "Block Size" "Access (ns)" "Area (mm²)" "Leakage (mW)"
echo "  $SEP"

for cfg in $CONFIGS/block_128B.cfg \
           $CONFIGS/block_064B.cfg \
           $CONFIGS/block_032B.cfg \
           $CONFIGS/block_016B.cfg; do

  block=$(grep "^-block size" $cfg | awk '{print $4}')
  out=$($CACTI -infile $cfg 2>/dev/null)

  access=$(echo "$out" | grep "Access time"          | head -1 | awk '{print $NF}')
  area=$(echo "$out"   | grep "Cache height x width" | head -1 | awk '{print $NF}')
  leak=$(echo "$out"   | grep "Total leakage power"  | head -1 | awk '{print $NF}')

  printf "  %-12s  %-14s  %-14s  %-14s\n" \
         "${block}B" "$access" "$area" "$leak"
done

