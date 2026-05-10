# Stable Demo Wrapper

## Purpose

The stable demo wrapper provides a repeatable way to run the main project validation path.

The script is located at:

scripts/demo/run-stable-demo.sh

## What It Runs

The wrapper validates the main runtime-aware SDN Traffic Engineering flow:

- workload services
- OVS edge segmentation policy
- TE metrics collector
- TE decision engine
- degraded path decision
- actuator API
- eBPF collector integration
- eBPF and TE correlation
- eBPF agent health inventory
- default Go eBPF agent validation

The native Go eBPF ring buffer canary is treated as optional because it is an advanced validation path.

## How To Run

Run from the repository root:

./scripts/demo/run-stable-demo.sh

## Logs

Demo logs are written under:

logs/demo/

The log directory is ignored by Git.

## Baseline Restore

The wrapper tries to restore the baseline at the end of the run.

It attempts to run:

- playbooks/12b-restore-path-costs.yml
- playbooks/12c-restore-critical-to-path1.yml

If one of these files is missing, it is skipped safely.

## Notes

This wrapper is intended for repeatable demos and regression checks.

It should not replace individual playbooks during development or troubleshooting.
