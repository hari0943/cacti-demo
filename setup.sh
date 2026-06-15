#!/bin/bash
set -e

CACTI_DIR="/workspaces/cacti-demo/cacti"

echo "=========================================="
echo "  CACTI Demo Environment Setup"
echo "=========================================="

# Clone CACTI source if not already present
if [ ! -d "$CACTI_DIR" ]; then
  echo "[1/3] Cloning HewlettPackard/cacti..."
  git clone --depth=1 https://github.com/HewlettPackard/cacti.git "$CACTI_DIR"
else
  echo "[1/3] CACTI source already present, skipping clone."
fi

# Build
echo "[2/3] Building CACTI (this takes ~30 seconds)..."
cd "$CACTI_DIR"
make -j$(nproc) 2>&1

# Verify
if [ -f "$CACTI_DIR/cacti" ]; then
  echo "[3/3] Build successful! Binary at: $CACTI_DIR/cacti"
else
  echo "[3/3] ERROR: Build failed. Check output above."
  exit 1
fi

echo ""
echo "=========================================="
echo "  Ready! Try running:"
echo "  cd cacti && ./cacti -infile ../demo_configs/l1_cache.cfg"
echo "=========================================="
