#!/bin/bash
# ============================================================
#  Run all demos in sequence
#  From inside cacti/ directory:  bash ../scripts/run_all.sh
# ============================================================

SCRIPTS=../scripts

echo ""
echo "╔═════════════════════════════════════════════════════════╗"
echo "║              CACTI Demo — Full Session                  ║"
echo "╚═════════════════════════════════════════════════════════╝"
echo ""
echo "  4 demos. Each builds on the last."
echo "  Press Enter between demos to continue."
echo ""

read -p "  Press Enter to start Demo 1 — Block Size..." _
bash $SCRIPTS/demo1_blocksize.sh

read -p "  Press Enter for Demo 2 — Cache Size..." _
bash $SCRIPTS/demo2_cachesize.sh

read -p "  Press Enter for Demo 3a — Banking Sweet Spot..." _
bash $SCRIPTS/demo3a_banking_sweetspot.sh

read -p "  Press Enter for Demo 3b — Banking Deep Dive..." _
bash $SCRIPTS/demo3b_banking_deepdive.sh

echo ""
echo "╔═════════════════════════════════════════════════════════╗"
echo "║                   Session Complete                      ║"
echo "╚═════════════════════════════════════════════════════════╝"
echo ""
