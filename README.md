# CACTI Demo — Faculty Workshop

> **One-click setup. No local install. Works on Windows, Mac, Linux — just a browser.**

## Launch Your Environment

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/hari0943/cacti-demo?quickstart=1)

> Need a GitHub account? Sign up free at [github.com](https://github.com) — takes 2 minutes.

Wait ~60 seconds. You'll land in a terminal with CACTI already compiled at `cacti/cacti`.

---

## How to Run

```bash
cd cacti
./cacti -infile ../demo_configs/<filename>
```

**Three numbers to read from the output:**
```
Access time (ns)             ← how long one read takes
Cache height x width (mm^2)  ← chip area
Total leakage power (mW)     ← power when idle
```

---

## Demo Sequence

### Run 1 — Baseline (32KB, 1 bank)
```bash
./cacti -infile ../demo_configs/01_baseline.cfg | grep -E "Access time|Cache height|leakage"
```
Expected: **0.418 ns**. This is your reference point.

---

### Run 2 — Cache Size Sweep
*Smaller cache = fewer rows = shorter column wire = faster access.*

```bash
./cacti -infile ../demo_configs/02_size_64kb.cfg | grep "Access time"   # 0.650 ns — bigger, slower
./cacti -infile ../demo_configs/01_baseline.cfg  | grep "Access time"   # 0.418 ns — baseline
./cacti -infile ../demo_configs/03_size_16kb.cfg | grep "Access time"   # 0.335 ns — smaller, faster
./cacti -infile ../demo_configs/04_size_8kb.cfg  | grep "Access time"   # 0.292 ns — smallest, fastest
```

| Cache size | Access time |
|---|---|
| 64 KB | 0.650 ns |
| **32 KB (baseline)** | **0.418 ns** |
| 16 KB | 0.335 ns |
| 8 KB | 0.292 ns |

**Ask the audience:** Is 8KB always the right choice? (No — you lose 75% of your capacity.)

---

### Run 3 — Banking Sweep
*Banks split the array so each bank has shorter wires — but more banks means more routing overhead between them.*

```bash
./cacti -infile ../demo_configs/01_baseline.cfg | grep "Access time"   # 0.418 ns — 1 bank
./cacti -infile ../demo_configs/05_banks_2.cfg  | grep "Access time"   # 0.375 ns — 2 banks ← sweet spot
./cacti -infile ../demo_configs/06_banks_4.cfg  | grep "Access time"   # 0.404 ns — 4 banks, slower!
./cacti -infile ../demo_configs/07_banks_8.cfg  | grep "Access time"   # 0.390 ns — 8 banks
```

| Banks | Access time | Note |
|---|---|---|
| 1 | 0.418 ns | baseline |
| **2** | **0.375 ns** | **sweet spot** |
| 4 | 0.404 ns | H-tree overhead kicks in |
| 8 | 0.390 ns | still slower than 2 |

**Ask the audience before running:** "Will more banks always be faster?"
They'll say yes. The table shows it isn't — and they have to explain why.

---

## The Five Parameters That Control Everything

```
-size (bytes)        total cache capacity
-block size (bytes)  size of one cache line
-associativity       1 = direct-mapped, 4/8/16 = set-associative
-technology (u)      chip generation: 0.090, 0.065, 0.045, 0.032
-UCA bank count      number of banks
```

Everything else in the config file is boilerplate — leave it alone.

---

## Stopping Your Codespace

Go to [github.com/codespaces](https://github.com/codespaces) → Stop.
Auto-stops after 30 minutes idle. Free accounts get 120 core-hours/month.
