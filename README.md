# CACTI Demo — CS6886

> **One-click setup. No local install needed. Works on Windows, Mac, and Linux.**

## Launch Your Environment

Click the button below — it opens a pre-built Linux terminal in your browser with CACTI already compiled and ready to run.

[![Open in GitHub Codespaces](https://github.com/codespaces/badge.svg)](https://codespaces.new/YOUR_USERNAME/cacti-demo?quickstart=1)

> **First time?** You need a free GitHub account. Sign up at [github.com](https://github.com) (takes 2 minutes).

The environment takes about **60 seconds** to start. You'll land in a VS Code terminal with CACTI compiled at `cacti/cacti`.

---

## Running CACTI

All demo configs are in `demo_configs/`. The general command is:

```bash
cd cacti
./cacti -infile ../demo_configs/<config_file>
```

### Demo 1 — L1 Cache (32KB, 8-way, 45nm)

```bash
cd cacti && ./cacti -infile ../demo_configs/l1_cache.cfg
```

### Demo 2 — L2 Cache (256KB, 8-way, 65nm)

```bash
./cacti -infile ../demo_configs/l2_cache.cfg
```

### Demo 3 — L3 Cache (8MB, 16-way, 32nm)

```bash
./cacti -infile ../demo_configs/l3_cache.cfg
```

---

## Key Output Fields to Watch

When CACTI runs, look for these lines in the output:

| Field | What it means |
|---|---|
| `Access time (ns)` | How long a cache read takes |
| `Cycle time (ns)` | Minimum time between two accesses |
| `Dynamic read energy (nJ)` | Energy per read operation |
| `Leakage power (mW)` | Static power even when idle |
| `Cache height / width (mm)` | Physical die area |

---

## Experimenting

Open any `.cfg` file in the editor and tweak parameters:

```
-size (bytes) 65536          # try doubling/halving cache size
-associativity 4             # try 1 (direct-mapped), 4, 8, 16
-technology (u) 0.032        # try 0.090, 0.065, 0.045, 0.032 (nm nodes)
-block size (bytes) 64       # cache line size
```

Re-run after each change and observe how access time, power, and area shift.

---

## Stopping Your Codespace

Go to [github.com/codespaces](https://github.com/codespaces), find your codespace, and click **Stop**. It will auto-stop after 30 minutes of inactivity anyway. You get **120 free core-hours/month** on a free GitHub account — more than enough.
