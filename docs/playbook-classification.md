# Playbook Classification

## Purpose

This document classifies the current Ansible playbooks into stable, experimental and archived groups.

The goal is to prepare the project for a clean GitHub structure without breaking the currently working lab.

## Classification Rules

| Group | Meaning |
|---|---|
| Stable | Used in the main demo path or required for repeatable validation |
| Experimental | Useful for advanced tests, canaries, research paths or future work |
| Archived | Older attempts, temporary fixes or replaced playbooks kept for reference |

## Stable Playbooks

These playbooks are part of the main working project path.

| Area | Playbook | Purpose |
|---|---|---|
| Workload validation | 08-verify-workload-services.yml | Verifies web, API and DB workload services |
| OVS edge policy | 10a-ovs-edge-policy-smoke.yml | Validates allow and deny policy behavior on OVS edge nodes |
| OVS overlay policy | 10b or related overlay policy playbook | Validates workload policy over the OVS overlay |
| TE metrics | 11d-verify-te-metrics-collector.yml | Validates latency and flow classification metrics |
| TE decision baseline | 12a-verify-te-decision-engine.yml | Verifies normal decision engine behavior |
| Critical path degradation | 12b-verify-critical-path-decision.yml | Verifies degraded path decision behavior |
| Path restore | 12b-restore-path-costs.yml | Restores normal path cost profile |
| Actuator API | 12d-verify-te-actuator.yml | Verifies actuator-based flow change and restore |
| eBPF JSON telemetry | 13c-verify-ebpf-json-telemetry.yml | Verifies eBPF JSON event generation |
| eBPF collector integration | 13d-verify-ebpf-collector-integration.yml | Verifies central eBPF event ingestion |
| eBPF and TE correlation | 13e-verify-ebpf-te-correlation.yml | Correlates host telemetry with network metrics |
| eBPF agent daemon | 14a-verify-ebpf-agent-daemon.yml | Verifies persistent agent telemetry |
| eBPF agent health | 14b-verify-ebpf-agent-health-api.yml | Verifies central agent health inventory |
| Config-driven agent | 14c-verify-ebpf-agent-config-state.yml | Verifies config-driven local state and collector events |
| Go agent skeleton | 14d-verify-go-ebpf-agent-skeleton.yml | Verifies Go agent contract with collector |
| Go stream canary | 14e-verify-go-ebpf-agent-stream-canary.yml | Verifies Go agent reading real bpftrace stream |
| Go default agent | 14f-verify-go-ebpf-agent-default.yml | Verifies Go agent as default runtime |
| Native eBPF canary | 15a-verify-native-go-ebpf-ringbuf-canary.yml | Verifies native Go eBPF ring buffer canary |

## Experimental Playbooks

These playbooks are useful but should not be part of the first stable demo path.

| Area | Playbook Type | Reason |
|---|---|---|
| P4/BMv2 early smoke | basic and smoke bridge playbooks | Useful for learning and reproducibility, but not the main demo path |
| P4Runtime experiments | early table programming playbooks | Useful for research notes and debugging |
| Native eBPF build fixes | 15a fix playbooks | Required for troubleshooting, but not part of normal demo flow |
| ONOS/P4 integration attempts | ONOS activation or netcfg scripts | Useful as future integration work |

## Archived Candidates

These files should be reviewed before moving to archived.

| Type | Reason |
|---|---|
| One-off fix playbooks | If they are replaced by cleaner final playbooks |
| Temporary debug playbooks | If they only helped diagnose an old issue |
| Broken early attempts | If they no longer represent the current working design |

## Current Decision

For now, files should not be moved.

The next step is to create a stable demo wrapper and then move files only after the demo path is confirmed.
