# Test Matrix

## Purpose

This document maps the project validation playbooks to the capabilities they verify.

The goal is to make the demo and regression path easier to understand.

## Stable Validation Path

| Order | Area | Playbook | Expected Result | Required |
|---|---|---|---|---|
| 1 | Workload services | playbooks/08-verify-workload-services.yml | Workload services are reachable | Yes |
| 2 | OVS edge policy | playbooks/10a-ovs-edge-policy-smoke.yml | OVS policy smoke passes | Yes |
| 3 | OVS overlay policy | playbooks/10b-ovs-edge-overlay-workload-policy.yml | Overlay workload policy passes | Optional |
| 4 | TE metrics | playbooks/11d-verify-te-metrics-collector.yml | TE metrics and flow classification pass | Yes |
| 5 | TE decision baseline | playbooks/12a-verify-te-decision-engine.yml | Decision engine keeps current paths | Yes |
| 6 | Critical path degradation | playbooks/12b-verify-critical-path-decision.yml | Decision engine recommends path shift | Yes |
| 7 | TE actuator | playbooks/12d-verify-te-actuator.yml | Actuator applies and restores path changes | Yes |
| 8 | eBPF collector integration | playbooks/13d-verify-ebpf-collector-integration.yml | eBPF events reach central collector | Yes |
| 9 | eBPF and TE correlation | playbooks/13e-verify-ebpf-te-correlation.yml | Host events and TE metrics are correlated | Yes |
| 10 | eBPF agent health | playbooks/14b-verify-ebpf-agent-health-api.yml | Agent health inventory passes | Yes |
| 11 | Default Go eBPF agent | playbooks/14f-verify-go-ebpf-agent-default.yml | Go bpftrace-stream agent works as default | Yes |
| 12 | Native Go eBPF canary | playbooks/15a-verify-native-go-ebpf-ringbuf-canary.yml | Native ring buffer canary passes | Optional |

## Expected PASS Markers

| Capability | Expected Marker |
|---|---|
| OVS edge policy | OVS_EDGE_POLICY_SMOKE_PASS |
| OVS overlay policy | OVS_EDGE_OVERLAY_WORKLOAD_POLICY_PASS |
| TE metrics baseline | TE_METRICS_COLLECTOR_BASELINE_PASS |
| TE decision baseline | TE_DECISION_ENGINE_BASELINE_PASS |
| Critical path decision | TE_DECISION_RECOMMEND_SHIFT_CRITICAL_TO_PATH2_PASS |
| TE actuator API | TE_ACTUATOR_API_BASELINE_PASS |
| eBPF collector integration | EBPF_TELEMETRY_COLLECTOR_INTEGRATION_PASS |
| eBPF and TE correlation | EBPF_TELEMETRY_TE_METRICS_CORRELATION_PASS |
| eBPF agent health | SDN_EBPF_AGENT_HEALTH_INVENTORY_PASS |
| Go default agent | SDN_GO_EBPF_AGENT_DEFAULT_PROMOTION_PASS |
| Native Go eBPF canary | SDN_NATIVE_GO_EBPF_RINGBUF_CANARY_PASS |

## Notes

The stable demo wrapper should rely on required playbooks only.

Optional playbooks can be used for advanced demonstrations, troubleshooting or research validation.

Native Go eBPF is currently treated as an optional canary validation path.
