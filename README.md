# CACTI Demo — Faculty Workshop

> **One-click setup. No local install. Works on Windows, Mac, Linux — just a browser.**

## Launch Your Environment

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/hari0943/cacti-demo?quickstart=1)

> Need a GitHub account? Sign up free at [github.com](https://github.com) — takes 2 minutes.

Wait ~60 seconds. You'll land in a terminal with CACTI already compiled at `cacti/cacti`.

---

## Running the Demos

All scripts must be run from inside the `cacti/` directory:

```bash
cd cacti
```

### Run everything in sequence
```bash
bash ../scripts/run_all.sh
```

### Or run each demo individually

```bash
bash ../scripts/demo1_blocksize.sh
bash ../scripts/demo2_cachesize.sh
bash ../scripts/demo3a_banking_sweetspot.sh
bash ../scripts/demo3b_banking_deepdive.sh
```

---

## What Each Demo Shows

### Demo 1 — Block Size Effect
**Configs:** `demo_configs/demo1_blocksize/`  
**Cache:** 512KB · direct-mapped · 45nm · 1 bank · normal mode

Smaller block → more tag bits → bigger tag array → slower access.

| Block Size | Access (ns) |
|---|---|
| 128B | 1.843 |
| 64B  | 1.880 |
| 32B  | 1.978 |
| 16B  | 2.175 |

---

### Demo 2 — Cache Size Effect
**Configs:** `demo_configs/demo2_cachesize/`  
**Cache:** direct-mapped · 64B block · 45nm · 1 bank · normal mode

Bigger cache → more rows → longer column wire → slower access.

| Cache Size | Access (ns) |
|---|---|
| 128KB  | 1.149 |
| 256KB  | 1.431 |
| 512KB  | 1.880 |
| 1024KB | 2.432 |

---

### Demo 3a — Banking: Sweet Spot
**Configs:** `demo_configs/demo3a_banking_sweetspot/`  
**Cache:** 32KB · direct-mapped · 64B block · 45nm · normal mode

Ask the audience before running: *"Will more banks always be faster?"*

| Banks | Access (ns) | Note |
|---|---|---|
| 1 | 0.418 | baseline |
| 2 | 0.375 | ✓ sweet spot |
| 4 | 0.404 | ✗ slower — H-tree overhead kicks in |
| 8 | 0.390 | still slower than 2 |

---

### Demo 3b — Banking: Deep Dive
**Configs:** `demo_configs/demo3b_banking_deepdive/`  
**Cache:** 512KB · direct-mapped · 64B block · 45nm · normal mode

CACTI re-optimises its internal subarray layout (Ndwl × Ndbl) at every bank count. Watch it simplify — then hit a wall.

| Banks | Access (ns) | Ndwl | Ndbl | Nspd | Phase |
|---|---|---|---|---|---|
| 1  | 1.880 | 4 | 8 | 4   | baseline |
| 2  | 1.690 | 4 | 4 | 4   | layout simplified |
| 4  | 1.544 | 2 | 4 | 2   | layout simplified |
| 8  | 1.409 | 2 | 2 | 2   | layout minimum ✓ |
| 16 | 1.453 | 2 | 2 | 1   | Ndwl/Ndbl stuck |
| 32 | 1.379 | 2 | 2 | 1   | recovers slightly |
| 64 | 1.414 | 2 | 2 | 0.5 | Nspd fractional, noisy |

---

## The Five Parameters That Control Everything

```
-size (bytes)        total cache capacity
-block size (bytes)  size of one cache line
-associativity       1 = direct-mapped
-technology (u)      chip generation: 0.090, 0.065, 0.045, 0.032
-UCA bank count      number of banks
```

Everything else in the config files is boilerplate — leave it alone.

---

## Stopping Your Codespace

Go to [github.com/codespaces](https://github.com/codespaces) → Stop.
Auto-stops after 30 minutes idle. Free accounts get 120 core-hours/month.
