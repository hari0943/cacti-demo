# CACTI Demo — CS6886 / Faculty Workshop

> **One-click setup. No local install. Works on Windows, Mac, Linux — just a browser.**

## Launch Your Environment

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/hari0943/cacti-demo?quickstart=1)

> Need a GitHub account? Sign up free at [github.com](https://github.com) — takes 2 minutes.

Wait about 60 seconds. You'll land in a terminal with CACTI already compiled at `cacti/cacti`.

---

## How to Run Any Config

```bash
cd cacti
./cacti -infile ../demo_configs/<filename>
```

Look for these lines in the output — ignore everything else:
- `Access time (ns)` — how long one read takes
- `Cache height x width (mm^2)` — chip area
- `Total leakage power (mW)` — power when idle
- `Total dynamic read energy (nJ)` — cost per access

---

## Demo Sequence (follows the slides)

### Slide 5 — Baseline
```bash
./cacti -infile ../demo_configs/01_baseline.cfg
```
32KB · 1-way · 64B block · 45nm · 1 bank. Record the numbers.

---

### Slide 6 — Fix 1: Smaller block size (64B → 32B)
```bash
./cacti -infile ../demo_configs/02_fix1_blocksize.cfg
```
Only change: `block size 64 → 32`. Same 32KB capacity.
Did access time go down? Fill the table on the slide.

---

### Slide 7 — Fix 2: Smaller cache (32KB → 16KB → 8KB)
```bash
./cacti -infile ../demo_configs/03_fix2a_size16kb.cfg
./cacti -infile ../demo_configs/04_fix2b_size8kb.cfg
```
Capacity drops. Access time drops too. Is the trade-off worth it?

---

### Slide 8 — Fix 3: Banking (1 → 2 → 4 banks)
```bash
./cacti -infile ../demo_configs/05_fix3a_banks2.cfg
./cacti -infile ../demo_configs/06_fix3b_banks4.cfg
```
Back to full 32KB. Banks split the array — shorter wires, faster access.
`06_fix3b_banks4.cfg` is the **final design** from Slide 9.

---

## The Five Parameters That Control Everything

Open any `.cfg` file and you'll see these at the top — everything else is boilerplate:

```
-size (bytes)       # total cache capacity
-block size (bytes) # size of one cache line
-associativity      # 1 = direct-mapped, 4/8/16 = set-associative
-technology (u)     # chip generation: 0.090, 0.065, 0.045, 0.032
-UCA bank count     # number of banks
```

---

## Stopping Your Codespace

Go to [github.com/codespaces](https://github.com/codespaces) → Stop.
It auto-stops after 30 minutes idle. Free accounts get 120 core-hours/month — plenty.
