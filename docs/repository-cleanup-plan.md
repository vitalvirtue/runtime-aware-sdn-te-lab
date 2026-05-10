# Repository Cleanup Plan

## Purpose

This document defines how the repository should be cleaned up without breaking the currently working lab.

The project already has a working prototype. The cleanup process should be conservative and reversible.

## Cleanup Principles

1. Do not move working playbooks before they are documented.
2. Do not delete experimental files immediately.
3. Prefer classification before refactoring.
4. Keep stable demo path easy to run.
5. Keep rollback and troubleshooting files available.
6. Avoid committing secrets, private keys, large logs or generated artifacts.

## Target Repository Structure

| Path | Purpose |
|---|---|
| docs/ | Project documentation, snapshots and demo notes |
| playbooks/ | Existing Ansible playbooks |
| playbooks/stable/ | Future location for stable demo playbooks |
| playbooks/experimental/ | Future location for research and canary playbooks |
| playbooks/archived/ | Future location for replaced or old debug playbooks |
| roles/ | Reusable Ansible roles |
| scripts/demo/ | Demo runner scripts |
| scripts/maintenance/ | Repo and lab maintenance scripts |
| services/ | Controller-side services |
| agents/ | eBPF agent implementations |
| p4/ | P4 programs and artifacts |
| policies/ | Segmentation and TE policy files |

## Stable Path

The stable path should contain only the playbooks required to demonstrate the main project flow.

Current stable demo areas:

- workload service validation
- OVS edge policy validation
- TE metrics validation
- decision engine validation
- degraded path decision validation
- actuator validation
- eBPF collector integration
- eBPF and TE correlation
- agent health validation
- default Go eBPF agent validation

## Experimental Path

The experimental path can contain:

- P4 and BMv2 early experiments
- ONOS integration attempts
- native Go eBPF canary files
- build fix playbooks
- one-off troubleshooting playbooks

Experimental does not mean useless. It means not required for the primary stable demo.

## Archived Path

The archived path can contain:

- old broken attempts
- replaced debug scripts
- temporary migration playbooks
- old one-off fixes

Archived files should be kept only if they are useful for learning or troubleshooting.

## Immediate Cleanup Actions

The next cleanup should be documentation-first:

1. Keep all current files in place.
2. Add test matrix and validation index.
3. Add stable demo wrapper.
4. Add repo hygiene check script.
5. Add this cleanup plan.
6. Only then start moving files in small commits.

## Future Cleanup Actions

Later, move files gradually:

1. Move stable verification playbooks to playbooks/stable.
2. Move advanced canary playbooks to playbooks/experimental.
3. Move old one-off fixes to playbooks/archived.
4. Update demo wrapper paths.
5. Run the stable demo wrapper.
6. Commit only after validation passes.

## Known Risk

Moving playbooks too early may break relative paths, service assumptions or existing documentation.

For this reason, file movement should happen after the stable demo wrapper is verified.
