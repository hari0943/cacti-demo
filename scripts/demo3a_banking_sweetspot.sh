#!/bin/bash
# ============================================================
#  DEMO 3a — Banking: Sweet Spot
#  Run from inside the cacti/ directory:
#  bash ../scripts/demo3a_banking_sweetspot.sh
# ============================================================

CACTI=./cacti
CONFIGS=../demo_configs/demo3a_banking_sweetspot
SEP="─────────────────────────────────────────────────────────"

echo ""
echo "╔═════════════════════════════════════════════════════════╗"
echo "║        DEMO 3a — Banking: Sweet Spot                    ║"
echo "║      32KB · direct-mapped · 64B block · 45nm            ║"
echo "╚═════════════════════════════════════════════════════════╝"
echo ""
echo "  Question for the audience: Will more banks always be faster?"
echo ""
read -p "  Press Enter to reveal the results..." _
echo ""
echo "  $SEP"
printf "  %-10s  %-14s  %-14s  %-10s\n" \
       "Banks" "Access (ns)" "Area (mm²)" "Note"
echo "  $SEP"

prev_access=""
for banks in 1 2 4 8; do
  cfg=$CONFIGS/banks_${banks}.cfg
  out=$($CACTI -infile $cfg 2>/dev/null)

  access=$(echo "$out" | grep "Access time"          | head -1 | awk '{print $NF}')
  area=$(echo "$out"   | grep "Cache height x width" | head -1 | awk '{print $NF}')

  note=""
  if [ "$banks" -eq 1 ]; then
    note="baseline"
  elif [ -n "$prev_access" ]; then
    # compare numerically
    faster=$(echo "$access $prev_access" | awk '{print ($1 < $2) ? "yes" : "no"}')
    if [ "$faster" = "yes" ]; then
      note="✓ faster"
    else
      note="✗ slower!"
    fi
  fi

  printf "  %-10s  %-14s  %-14s  %-10s\n" \
         "$banks" "$access" "$area" "$note"
  prev_access=$access
done

