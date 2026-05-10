# Component Inventory

## Controller Node Components

| Component | Location | Purpose |
|---|---|---|
| TE Metrics Collector | controller node | Collects latency, flow counters and eBPF events |
| TE Decision Engine | controller node | Evaluates path state and recommends actions |
| TE Actuator API | controller node | Applies and restores OVS flow changes |
| eBPF Agent Health API | controller node | Reports agent status and inventory |
| Correlation API | controller node | Joins eBPF host events with TE network metrics |

## Edge Node Components

| Component | Location | Purpose |
|---|---|---|
| OVS bridge | edge nodes | Performs forwarding and policy enforcement |
| OVS flows | edge nodes | Implements path and policy behavior |
| Path interfaces | edge nodes | Represent traffic engineering paths |

## Workload Node Components

| Component | Location | Purpose |
|---|---|---|
| sdn-ebpf-agent.service | workload nodes | Sends workload TCP telemetry to collector |
| config.json | /etc/sdn-ebpf-agent/config.json | Defines segment, collector URL and flow rules |
| agent_state.json | /opt/sdn-lab/ebpf/state/agent_state.json | Stores local agent state |
| Go agent binary | /opt/sdn-lab/ebpf/go-agent/sdn-ebpf-agent | Current stable agent implementation |
| Native eBPF canary | /opt/sdn-lab/ebpf/native-agent/ | Experimental native eBPF implementation |

## Fabric Node Components

| Component | Location | Purpose |
|---|---|---|
| P4 programs | fabric node | Programmable data plane experiments |
| BMv2 artifacts | fabric node | Compiled P4 artifacts |
| Mininet topologies | fabric node | P4/BMv2 smoke tests |

## Ops Node Components

| Component | Location | Purpose |
|---|---|---|
| Ansible inventory | repository | Defines lab hosts and groups |
| Ansible playbooks | repository | Deploy and verify lab components |
| Demo scripts | scripts/demo | Runs repeatable validation flows |
| Documentation | docs | Project documentation and snapshots |
