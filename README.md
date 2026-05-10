# Runtime-Aware SDN Traffic Engineering Lab

A homelab research prototype for runtime-aware SDN Traffic Engineering with OVS, P4/BMv2 experiments, eBPF workload telemetry, and controller-side decision/actuation services.

This project demonstrates how host-level runtime telemetry and network-level traffic engineering metrics can be correlated to support path decisions for critical workload traffic.

## Project Goal

The goal is to build a realistic but manageable SDN lab that can:

- identify workload-level TCP flows with eBPF agents
- classify traffic by segment and flow_class
- collect OVS flow counters and latency metrics
- make traffic engineering decisions
- apply path changes through an actuator API
- correlate host runtime events with network metrics
- provide a repeatable Ansible-driven validation flow

This is a research and homelab prototype, not a production-ready SDN controller.

## High-Level Architecture

Main roles:

| Role | Example Host | Purpose |
|---|---|---|
| Ops | lab-sdn-ops-ansible-01 | Ansible control node and repository workspace |
| Controller | lab-sdn-ctrl-onos-01 | Metrics collector, decision engine, actuator API and agent health API |
| Fabric | lab-sdn-core-fabric-01 | P4/BMv2 experiments and programmable data plane tests |
| Edge | lab-sdn-edge-ovs-a-01, lab-sdn-edge-ovs-b-01 | OVS edge forwarding, segmentation and traffic engineering behavior |
| Workloads | web, api, db, bulk nodes | Application traffic sources and eBPF telemetry agents |

Main runtime flow:

1. Workload nodes generate traffic.
2. eBPF agents observe TCP connect events.
3. Agents enrich events with host, segment, destination IP, destination port and flow_class.
4. Events are sent to the controller-side collector.
5. OVS edge nodes provide path and counter metrics.
6. The decision engine evaluates path health.
7. The actuator API can update OVS flows.
8. Correlation endpoints join host telemetry and network metrics.

## Verified Capabilities

| Capability | Status |
|---|---|
| Workload service validation | Passed |
| OVS edge segmentation policy | Passed |
| OVS overlay workload policy | Passed |
| TE metrics collector | Passed |
| TE decision engine | Passed |
| Degraded path decision | Passed |
| TE actuator API | Passed |
| eBPF TCP connect telemetry | Passed |
| eBPF collector integration | Passed |
| eBPF and TE metric correlation | Passed |
| Persistent eBPF agent daemon | Passed |
| eBPF agent health inventory | Passed |
| Config-driven eBPF agent state | Passed |
| Go bpftrace-stream agent | Passed |
| Native Go eBPF ring buffer canary | Passed |

## Current Stable Runtime

| Component | Runtime |
|---|---|
| Workload telemetry agent | sdn-ebpf-agent.service |
| Stable agent implementation | Go agent reading bpftrace stream |
| Native eBPF implementation | Validated as canary |
| Collector | TE Metrics Collector |
| Decision logic | Rule and threshold based |
| Actuation | API-driven OVS flow update |

## Traffic Classes

| Flow Class | Meaning |
|---|---|
| web_to_api | Web workload connects to API workload |
| critical_api_to_db | API workload connects to DB workload |
| db_to_api | DB workload connects to API workload |
| bulk_to_api | Bulk workload connects to API workload |
| denied_web_to_db | Web to DB traffic should be denied |
| denied_bulk_to_db | Bulk to DB traffic should be denied |

## Stable Demo

The stable demo path validates:

1. workload services
2. OVS edge policy
3. TE metrics collector
4. decision engine baseline
5. degraded critical path decision
6. actuator API
7. eBPF collector integration
8. eBPF and TE correlation
9. eBPF agent health inventory
10. default Go eBPF agent

Dry-run check:

./scripts/demo/check-stable-demo-plan.sh

Full stable demo:

./scripts/demo/run-stable-demo.sh

## Repository Layout

| Path | Purpose |
|---|---|
| docs/ | Project documentation and snapshots |
| inventory/ | Ansible inventory |
| playbooks/ | Ansible deployment and validation playbooks |
| roles/ | Reusable Ansible roles |
| scripts/demo/ | Demo runner scripts |
| scripts/maintenance/ | Maintenance and hygiene scripts |
| services/ | Controller-side service source or packaging area |
| agents/ | eBPF agent source or packaging area |
| p4/ | P4 programs and artifacts |
| policies/ | Policy definitions |

## Documentation

| Document | Purpose |
|---|---|
| docs/current-state.md | Current working lab state |
| docs/architecture.md | Architecture overview |
| docs/component-inventory.md | Component inventory |
| docs/project-summary.md | Project summary |
| docs/demo-guide.md | Stable demo story |
| docs/test-matrix.md | Validation matrix |
| docs/validation-index.md | What each validation proves |
| docs/playbook-classification.md | Stable, experimental and archived classification |
| docs/repository-cleanup-plan.md | Cleanup strategy |
| docs/dashboard-roadmap.md | Dashboard plan |
| docs/github-publishing.md | GitHub publishing guide |
| docs/roadmap.md | Project roadmap |

## Known Limitations

- ONOS exists as part of the controller-plane lab role, but the runtime control loop currently uses lightweight custom services.
- P4/BMv2 is used for programmable data plane experiments; the main workload traffic engineering demo currently runs on the OVS overlay path.
- The decision engine is rule and threshold based; ML-based decision logic is not implemented yet.
- Native Go eBPF is validated as a canary path, but the stable runtime remains the Go bpftrace-stream agent.
- Authentication, authorization, multi-tenancy and production hardening are not implemented.
- This repository is intended for homelab research, learning and demonstration.

## Roadmap

Short-term:

- finalize GitHub packaging
- add a small read-only dashboard
- improve demo documentation
- keep stable and experimental paths clearly separated

Mid-term:

- add dashboard views for agent health, eBPF events and TE correlation
- improve service packaging
- add regression wrapper for stable validation
- decide how far ONOS/P4 integration should go

Long-term:

- introduce scoring or ML-assisted decision logic
- promote native Go eBPF from canary to selectable runtime
- improve visualization and reporting
- publish a structured technical write-up
