# Validation Index

## Purpose

This document summarizes what has been validated in the lab and why each validation matters.

## Validated Areas

### 1. Workload Connectivity

Validated by:

- playbooks/08-verify-workload-services.yml

Why it matters:

The rest of the demo depends on healthy workload services.

### 2. Segmentation Policy

Validated by:

- playbooks/10a-ovs-edge-policy-smoke.yml
- optional overlay workload policy playbook

Why it matters:

The lab must show that traffic is not fully open. Only approved flows should work.

Validated policy examples:

| Flow | Expected |
|---|---|
| web to api | allow |
| api to db | allow |
| web to db | deny |
| bulk to db | deny |

### 3. Traffic Engineering Metrics

Validated by:

- playbooks/11d-verify-te-metrics-collector.yml

Why it matters:

The controller needs latency and flow counter visibility before it can make path decisions.

### 4. Decision Engine

Validated by:

- playbooks/12a-verify-te-decision-engine.yml
- playbooks/12b-verify-critical-path-decision.yml

Why it matters:

The project needs a control-plane decision layer that can react to degraded path conditions.

Current behavior:

- keep current paths when critical latency is healthy
- recommend moving critical traffic when the critical path is degraded

### 5. Actuator API

Validated by:

- playbooks/12d-verify-te-actuator.yml

Why it matters:

A decision is only useful if the system can enforce it.

The actuator API updates OVS flows and restores the baseline state.

### 6. eBPF Telemetry

Validated by:

- playbooks/13c-verify-ebpf-json-telemetry.yml
- playbooks/13d-verify-ebpf-collector-integration.yml

Why it matters:

The project needs host-level visibility, not only network counters.

eBPF telemetry provides:

- process name
- host
- segment
- destination IP
- destination port
- flow_class

### 7. eBPF and TE Correlation

Validated by:

- playbooks/13e-verify-ebpf-te-correlation.yml

Why it matters:

This connects workload-level runtime behavior to network-level traffic engineering behavior.

The system can show which workload process initiated a flow and how that flow behaves in the network.

### 8. Persistent eBPF Agent

Validated by:

- playbooks/14a-verify-ebpf-agent-daemon.yml
- playbooks/14b-verify-ebpf-agent-health-api.yml
- playbooks/14c-verify-ebpf-agent-config-state.yml

Why it matters:

The system needs a manageable agent model, not only short smoke scripts.

Validated capabilities:

- systemd-based agent runtime
- central agent health inventory
- config-driven flow classification
- local state reporting

### 9. Go Agent Path

Validated by:

- playbooks/14d-verify-go-ebpf-agent-skeleton.yml
- playbooks/14e-verify-go-ebpf-agent-stream-canary.yml
- playbooks/14f-verify-go-ebpf-agent-default.yml

Why it matters:

The project moves from quick prototype scripts toward a maintainable Go agent implementation.

Current stable runtime:

- Go agent reading bpftrace stream

### 10. Native Go eBPF Canary

Validated by:

- playbooks/15a-verify-native-go-ebpf-ringbuf-canary.yml

Why it matters:

This proves that the project can move beyond bpftrace stream parsing.

Validated native path:

- eBPF C program
- kprobe tcp_v4_connect
- ring buffer
- Go userspace reader
- collector integration

Current status:

Native Go eBPF is validated as a canary path, not the default stable runtime.
