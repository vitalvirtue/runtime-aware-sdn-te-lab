# Architecture

## Overview

This project is a homelab research prototype for runtime-aware SDN Traffic Engineering.

The system combines workload-level eBPF telemetry, OVS-based edge forwarding, P4/BMv2 experiments, and controller-side services for metrics collection, decision making and actuation.

The current stable demo path is based on the OVS overlay and Go-based eBPF agent telemetry.

P4/BMv2 and native Go eBPF are included as validated experimental paths.

## High-Level Flow

The main runtime flow is:

1. Workload nodes generate application traffic.
2. eBPF agents observe TCP connect events on workload nodes.
3. Agents enrich events with segment and flow_class information.
4. Events are sent to the controller-side TE Metrics Collector.
5. OVS edge nodes expose flow counters and path behavior.
6. The metrics collector combines host telemetry and network metrics.
7. The decision engine evaluates path state.
8. The actuator API can update OVS flows.
9. Verification playbooks validate the result.

## Lab Roles

| Role | Host | Purpose |
|---|---|---|
| Ops | lab-sdn-ops-ansible-01 | Ansible control node and repository workspace |
| Controller | lab-sdn-ctrl-onos-01 | Controller-side APIs, metrics, decision engine and actuator |
| Fabric | lab-sdn-core-fabric-01 | P4/BMv2 experiments and programmable data plane tests |
| Edge A | lab-sdn-edge-ovs-a-01 | OVS edge node and TE path endpoint |
| Edge B | lab-sdn-edge-ovs-b-01 | OVS edge node and TE path endpoint |
| Web | lab-sdn-app-web-01 | Web workload segment |
| API | lab-sdn-app-api-01 | API workload segment |
| DB | lab-sdn-data-db-01 | Database workload segment |
| Bulk | lab-sdn-app-bulk-01 | Bulk traffic workload segment |

## Main Components

### TE Metrics Collector

Runs on the controller node.

Responsibilities:

- collect latency measurements
- collect OVS flow counters
- ingest eBPF telemetry events
- expose current telemetry through API endpoints
- provide correlation between host events and network metrics

### TE Decision Engine

Runs on the controller node.

Responsibilities:

- evaluate current latency and path state
- keep current paths when critical traffic is healthy
- recommend shifting critical traffic when the critical path is degraded

The current decision engine is rule and threshold based.

### TE Actuator API

Runs on the controller node.

Responsibilities:

- apply OVS flow changes
- shift critical traffic between paths
- restore the baseline flow state

### OVS Edge Layer

Runs on edge nodes.

Responsibilities:

- enforce allow and deny policy behavior
- provide path forwarding for critical and bulk traffic
- expose counters for TE metrics

### eBPF Agent

Runs on workload nodes.

Current stable runtime:

- systemd service: sdn-ebpf-agent.service
- implementation: Go binary reading bpftrace stream
- event type: TCP connect telemetry
- enrichment: host, segment, destination IP, destination port and flow_class

Validated experimental runtime:

- native Go eBPF ring buffer canary

### P4/BMv2 Fabric Experiments

Runs on the fabric node.

Responsibilities:

- validate P4 program behavior
- validate table-driven segmentation concepts
- test programmable data plane ideas

The main workload TE demo currently runs on the OVS overlay path, not on a full P4-based fabric.

## Traffic Classes

| Flow Class | Meaning |
|---|---|
| web_to_api | Web workload connects to API workload |
| critical_api_to_db | API workload connects to DB workload |
| db_to_api | DB workload connects to API workload |
| bulk_to_api | Bulk workload connects to API workload |
| denied_web_to_db | Web to DB traffic should be denied |
| denied_bulk_to_db | Bulk to DB traffic should be denied |

## Stable Demo Path

The stable demo focuses on:

1. workload service validation
2. OVS policy validation
3. TE metrics collection
4. decision engine evaluation
5. degraded path behavior
6. actuator-based flow update
7. eBPF telemetry ingestion
8. eBPF and TE correlation
9. agent health validation

## Experimental Paths

The following areas are validated but should be treated as experimental or advanced:

- P4/BMv2 fabric experiments
- native Go eBPF ring buffer canary
- ONOS/P4 integration attempts
- ML-based decision logic

## Known Limitations

This is not a production-ready SDN platform.

Current limitations:

- ONOS is present as a controller-plane lab role, but the runtime control loop is implemented through custom lightweight services.
- The main workload TE demo currently runs on the OVS overlay path.
- P4/BMv2 is used for programmable data plane experiments, not as the only forwarding path for the full demo.
- The decision engine is rule and threshold based.
- Native Go eBPF is validated as a canary path but is not yet the default stable runtime.
- Security hardening, authentication and multi-tenant controls are not implemented.
