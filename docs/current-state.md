# Current Project State

## Purpose

This document captures the current working state of the SDN/eBPF traffic engineering lab.

## Lab Roles

| Role | Example Host | Purpose |
|---|---|---|
| Ops | lab-sdn-ops-ansible-01 | Ansible control node |
| Controller | lab-sdn-ctrl-onos-01 | Controller-side APIs and services |
| Fabric | lab-sdn-core-fabric-01 | P4/BMv2 and fabric experiments |
| Edge | lab-sdn-edge-ovs-a-01 / lab-sdn-edge-ovs-b-01 | OVS edge forwarding and TE paths |
| Workloads | web/api/db/bulk nodes | Application traffic sources and sinks |

## Main Capabilities Verified

- OVS edge policy smoke tests
- Traffic engineering metrics collection
- Decision engine baseline and degraded-path decision
- Actuator API flow updates
- eBPF TCP connect telemetry
- Central eBPF event collection
- eBPF and TE metric correlation
- Persistent eBPF agent service
- Go eBPF agent skeleton and stream canary
- Native Go eBPF ring buffer canary

## Current Stabilization Goal

The next goal is to organize the repository, document the working architecture, and prepare a repeatable GitHub-ready demo flow.
