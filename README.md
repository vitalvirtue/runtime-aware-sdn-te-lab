# Runtime-Aware SDN Traffic Engineering Lab

This repository contains a homelab research prototype for runtime-aware SDN traffic engineering.

The project combines:

- OVS-based edge forwarding and policy enforcement
- P4/BMv2 experiments for programmable data plane concepts
- eBPF-based workload telemetry
- Controller-side metrics collection, decision logic, and actuation
- Ansible-based deployment and validation workflows

## Current Status

This project is currently in stabilization and packaging phase.

The working prototype already validates:

- workload service checks
- segmentation policy smoke tests
- traffic engineering metrics
- decision engine behavior
- actuator-based path changes
- eBPF workload telemetry
- eBPF and TE metric correlation
- Go-based eBPF agent migration experiments
- native Go eBPF ring buffer canary

## Repository Layout

```text
docs/                  Project documentation
playbooks/             Ansible playbooks
scripts/               Demo and maintenance scripts
services/              Controller-side services
agents/                eBPF agent implementations
p4/                    P4 programs and artifacts
policies/              Policy definitions

## Scope

This is a research and homelab prototype, not a production-ready SDN controller.

## Known Limitations
The current decision engine is rule/threshold based, not ML-based.
ONOS is part of the controller-plane lab role, but the runtime control loop is currently implemented with lightweight custom services.
P4/BMv2 is used for programmable data plane experiments; the main workload TE demo currently runs through the OVS overlay path.
Native Go eBPF support is validated as a canary path, while the stable agent path is still being refined.


## Documentation

Main documentation files:

- docs/current-state.md
- docs/architecture.md
- docs/component-inventory.md
- docs/demo-guide.md
- docs/playbook-classification.md
- docs/stable-demo-wrapper.md
- docs/milestones.md
- docs/roadmap.md
- docs/test-matrix.md
- docs/validation-index.md

