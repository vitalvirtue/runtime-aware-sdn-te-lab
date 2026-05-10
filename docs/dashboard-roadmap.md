# Dashboard Roadmap

## Purpose

A small read-only dashboard can make the project easier to demo and understand.

The dashboard should not become a large product UI at this stage. It should visualize the current controller-side APIs.

## Recommended First Version

A minimal read-only dashboard.

Suggested views:

| View | Description |
|---|---|
| System Health | Shows collector and service health |
| Agent Health | Shows eBPF agent inventory and last_seen |
| eBPF Events | Shows latest TCP connect telemetry events |
| TE Metrics | Shows current latency and flow counters |
| Decision | Shows latest decision engine output |
| Correlation | Shows host telemetry and network metrics joined by flow_class |

## Suggested Implementation

Start simple.

Recommended stack:

- FastAPI endpoint serving static HTML
- plain HTML, CSS and JavaScript
- fetch existing controller APIs
- no database
- no authentication for local lab demo

## Existing APIs To Use

| API | Purpose |
|---|---|
| /health | Collector health |
| /ebpf/agents/status | eBPF agent health |
| /ebpf/events/current | Latest eBPF events |
| /correlation/current | Host and network correlation |
| /policy/current | Current policy state |
| /decision/evaluate | Current decision output if available |

## Why Not React First

React is useful, but it may be unnecessary for the first dashboard.

A static dashboard is easier to ship, explain and maintain for a homelab research project.

React can be added later if the dashboard grows.

## Milestone 17 Proposal

Milestone 17 should implement:

1. static dashboard scaffold
2. controller API polling
3. agent health table
4. latest eBPF events table
5. correlation summary
6. simple demo-friendly styling
