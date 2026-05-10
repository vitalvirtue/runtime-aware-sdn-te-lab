# Project Summary

## One-Line Summary

This project demonstrates a runtime-aware SDN Traffic Engineering prototype that correlates eBPF workload telemetry with OVS-based network metrics to support path decisions for critical traffic.

## What Was Built

The lab includes:

- Proxmox-based multi-VM lab topology
- Ansible-driven deployment and validation
- OVS edge policy and overlay traffic engineering
- P4/BMv2 programmable data plane experiments
- Controller-side metrics collector
- Decision engine for path evaluation
- Actuator API for OVS flow updates
- eBPF workload telemetry agents
- eBPF event collector
- Agent health inventory API
- eBPF and TE metric correlation
- Go-based telemetry agent path
- Native Go eBPF ring buffer canary

## Main Technical Value

The project connects two visibility layers.

Host runtime telemetry:

- which process initiated a connection
- on which workload node
- from which segment
- to which destination IP and port

Network telemetry:

- which flow_class was observed
- which path was used
- what latency was measured
- what packet counters were observed

The correlation layer joins these views by flow_class.

## Main Demo Scenario

The stable demo shows:

1. allowed and denied workload flows
2. critical and bulk traffic classes
3. normal path decision
4. degraded critical path decision
5. actuator-based path change
6. latency improvement
7. eBPF telemetry event collection
8. eBPF and TE correlation
9. agent health inventory

## Current Scope

This is a working research prototype.

It is suitable for:

- portfolio demonstration
- thesis or course project foundation
- SDN, eBPF and traffic engineering learning
- future research experimentation

It is not yet suitable as a production network control system.

## Next Suggested Work

The most valuable next step is a small read-only dashboard.

The dashboard should show:

- controller health
- eBPF agent health
- latest eBPF events
- current TE decision
- latest eBPF and TE correlation
- stable demo status
