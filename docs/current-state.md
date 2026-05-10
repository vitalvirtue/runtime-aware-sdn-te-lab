# Current Project State

## Purpose

This document captures the current working state of the runtime-aware SDN Traffic Engineering lab.

The goal of this phase is to stabilize the project, document the working architecture, and prepare the repository for GitHub.

## Lab Roles

| Role | Host Pattern | Purpose |
|---|---|---|
| Ops | lab-sdn-ops-ansible-01 | Ansible control node and project workspace |
| Controller | lab-sdn-ctrl-onos-01 | Controller-side APIs, metrics, decision and actuator services |
| Fabric | lab-sdn-core-fabric-01 | P4/BMv2 experiments and programmable data plane tests |
| Edge | lab-sdn-edge-ovs-a-01, lab-sdn-edge-ovs-b-01 | OVS edge forwarding, policy and traffic engineering paths |
| Workloads | web, api, db, bulk nodes | Application traffic sources and telemetry agents |

## Verified Capabilities

The following capabilities have been validated in the lab:

| Area | Status | Notes |
|---|---|---|
| Workload service checks | Passed | Web, API, DB and bulk workload services are reachable in the lab |
| OVS edge policy | Passed | Allow and deny policies were validated on OVS edge nodes |
| Traffic Engineering metrics | Passed | Latency and flow counters are collected by the controller-side metrics service |
| Decision engine | Passed | Baseline and degraded-path decisions were validated |
| Actuator API | Passed | OVS flow changes can be applied and restored through an API |
| eBPF TCP telemetry | Passed | TCP connect events are collected from workload nodes |
| eBPF collector integration | Passed | Workload telemetry is sent to the controller-side collector |
| eBPF and TE correlation | Passed | Host events and network metrics are correlated by flow_class |
| Persistent eBPF agent | Passed | Workload nodes run a persistent sdn-ebpf-agent service |
| Agent health API | Passed | The controller can report agent status, segment, event count and last_seen |
| Go agent path | Passed | Go-based bpftrace stream agent was promoted as the default path |
| Native Go eBPF canary | Passed | Native ring buffer based eBPF canary was validated successfully |

## Current Stable Runtime

The current stable agent runtime is:

| Component | Current Runtime |
|---|---|
| eBPF agent service | sdn-ebpf-agent.service |
| Agent implementation | Go binary reading bpftrace stream |
| Native eBPF implementation | Validated as canary, not yet default |
| Collector | TE Metrics Collector on controller node |
| Decision engine | Rule and threshold based |
| Actuator | API-driven OVS flow update |

## Important Design Notes

This project is a research and homelab prototype.

ONOS exists as part of the controller-plane lab role, but the current runtime control loop is implemented through lightweight custom services.

P4/BMv2 is used for programmable data plane experiments. The main workload traffic engineering demo currently runs on the OVS overlay path.

Native Go eBPF support has been validated as a canary path. The current stable runtime remains the Go agent that reads the bpftrace stream.

The decision engine is currently rule and threshold based. ML-based decision logic is not implemented yet.

## Snapshot Files

Live state snapshots are stored under:

- docs/snapshots/inventory-graph.txt
- docs/snapshots/lab-ping.txt
- docs/snapshots/control-services.txt
- docs/snapshots/edge-ovs-state.txt
- docs/snapshots/workload-ebpf-agents.txt
- docs/snapshots/collector-health.txt

These files are used as a lightweight record of the working lab state during stabilization.

## Next Step

The next step is to organize stable, experimental and archived playbooks without breaking the current working system.
