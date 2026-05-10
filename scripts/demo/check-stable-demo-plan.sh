#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "${ROOT_DIR}"

echo "== Stable demo dry-run check =="

echo
echo "== Repository root =="
echo "${ROOT_DIR}"

echo
echo "== Check demo wrapper syntax =="
bash -n scripts/demo/run-stable-demo.sh
echo "OK scripts/demo/run-stable-demo.sh"

required_playbooks=(
  "playbooks/08-verify-workload-services.yml|Validate workload services"
  "playbooks/10a-ovs-edge-policy-smoke.yml|Validate OVS edge segmentation policy"
  "playbooks/11d-verify-te-metrics-collector.yml|Validate TE metrics collector"
  "playbooks/12a-verify-te-decision-engine.yml|Validate TE decision baseline"
  "playbooks/12b-verify-critical-path-decision.yml|Validate degraded critical path decision"
  "playbooks/12d-verify-te-actuator.yml|Validate TE actuator API"
  "playbooks/13d-verify-ebpf-collector-integration.yml|Validate eBPF collector integration"
  "playbooks/13e-verify-ebpf-te-correlation.yml|Validate eBPF and TE correlation"
  "playbooks/14b-verify-ebpf-agent-health-api.yml|Validate eBPF agent health inventory"
  "playbooks/14f-verify-go-ebpf-agent-default.yml|Validate default Go eBPF agent"
)

optional_playbooks=(
  "playbooks/10b-ovs-edge-overlay-workload-policy.yml|Validate OVS overlay workload policy"
  "playbooks/15a-verify-native-go-ebpf-ringbuf-canary.yml|Validate native Go eBPF ring buffer canary"
)

echo
echo "== Required playbooks =="
for item in "${required_playbooks[@]}"; do
  playbook="${item%%|*}"
  title="${item#*|}"

  if [ ! -f "${playbook}" ]; then
    echo "MISSING required: ${playbook} - ${title}"
    exit 1
  fi

  echo "OK required: ${playbook} - ${title}"
done

echo
echo "== Optional playbooks =="
for item in "${optional_playbooks[@]}"; do
  playbook="${item%%|*}"
  title="${item#*|}"

  if [ ! -f "${playbook}" ]; then
    echo "SKIP optional missing: ${playbook} - ${title}"
  else
    echo "OK optional: ${playbook} - ${title}"
  fi
done

echo
echo "== Ansible syntax check for required playbooks =="
for item in "${required_playbooks[@]}"; do
  playbook="${item%%|*}"
  echo "syntax-check required: ${playbook}"
  ansible-playbook "${playbook}" --syntax-check >/dev/null
done

echo
echo "== Ansible syntax check for existing optional playbooks =="
for item in "${optional_playbooks[@]}"; do
  playbook="${item%%|*}"

  if [ -f "${playbook}" ]; then
    echo "syntax-check optional: ${playbook}"
    ansible-playbook "${playbook}" --syntax-check >/dev/null
  fi
done

echo
echo "== Demo plan =="
step=1
for item in "${required_playbooks[@]}"; do
  playbook="${item%%|*}"
  title="${item#*|}"
  printf "%02d REQUIRED %-60s %s\n" "${step}" "${title}" "${playbook}"
  step=$((step + 1))
done

for item in "${optional_playbooks[@]}"; do
  playbook="${item%%|*}"
  title="${item#*|}"

  if [ -f "${playbook}" ]; then
    printf "%02d OPTIONAL %-60s %s\n" "${step}" "${title}" "${playbook}"
    step=$((step + 1))
  fi
done

echo
echo "STABLE_DEMO_DRY_RUN_PASS"
