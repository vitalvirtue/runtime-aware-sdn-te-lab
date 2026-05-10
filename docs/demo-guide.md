# Stable Demo Guide

## Purpose

This guide defines the stable end-to-end demo path for the runtime-aware SDN Traffic Engineering lab.

The demo should be realistic, repeatable and easy to explain.

## Demo Story

The lab demonstrates a closed-loop traffic engineering prototype.

The system observes network and host telemetry, makes a path decision, applies policy through an actuator and verifies the result.

## Demo Flow

### 1. Validate workload services

Goal:

Confirm that the workload services are reachable.

Expected result:

Web, API and DB service checks pass.

### 2. Validate segmentation policy

Goal:

Show that the network is not fully open.

Expected result:

Allowed flows pass.

Denied flows fail.

Example policy:

| Flow | Expected |
|---|---|
| web to api | allow |
| api to db | allow |
| web to db | deny |
| bulk to db | deny |

### 3. Validate TE metrics

Goal:

Show that the controller can collect latency and OVS flow counter metrics.

Expected result:

Critical and bulk flow metrics are visible.

### 4. Validate decision engine baseline

Goal:

Show that the decision engine keeps the current path when latency is normal.

Expected result:

The decision engine returns keep_current_paths.

### 5. Simulate critical path degradation

Goal:

Introduce latency on the critical path.

Expected result:

The decision engine recommends moving critical traffic to path-2.

### 6. Apply actuator action

Goal:

Apply path change through the actuator API.

Expected result:

Critical traffic is moved and latency improves.

### 7. Validate eBPF telemetry

Goal:

Show that workload agents detect process-level TCP connect events.

Expected result:

The controller receives eBPF events with host, segment, process, destination IP, destination port and flow_class.

### 8. Validate eBPF and TE correlation

Goal:

Show that host telemetry and network telemetry are joined by flow_class.

Expected result:

The same flow_class contains host-level event data and network-level metrics.

### 9. Restore baseline

Goal:

Return the lab to the normal state.

Expected result:

Path costs and default agent runtime are restored.

## Stable Demo Principle

The demo should prefer stable playbooks.

Experimental native eBPF canary can be shown as an advanced optional step, but it should not be required for the main demo.

## Known Limitations During Demo

- Decision logic is rule and threshold based.
- ONOS is present as a controller-plane role, but the current control loop uses lightweight custom services.
- P4/BMv2 experiments are separate from the main OVS overlay workload TE demo.
- Native Go eBPF is validated as canary, while the stable runtime remains the Go bpftrace-stream agent.
