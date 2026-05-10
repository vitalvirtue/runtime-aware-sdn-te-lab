#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
LOG_DIR="${ROOT_DIR}/logs/demo"
RUN_ID="$(date -u +%Y%m%dT%H%M%SZ)"
LOG_FILE="${LOG_DIR}/stable-demo-${RUN_ID}.log"

mkdir -p "${LOG_DIR}"

cd "${ROOT_DIR}"

log() {
  echo "[$(date -u +%Y-%m-%dT%H:%M:%SZ)] $*" | tee -a "${LOG_FILE}"
}

run_required() {
  local playbook="$1"
  local title="$2"

  if [ ! -f "${playbook}" ]; then
    log "ERROR: required playbook not found: ${playbook}"
    exit 1
  fi

  log "START required: ${title}"
  log "PLAYBOOK: ${playbook}"

  ansible-playbook "${playbook}" 2>&1 | tee -a "${LOG_FILE}"

  log "PASS required: ${title}"
}

run_optional() {
  local playbook="$1"
  local title="$2"

  if [ ! -f "${playbook}" ]; then
    log "SKIP optional: ${title}"
    log "MISSING: ${playbook}"
    return 0
  fi

  log "START optional: ${title}"
  log "PLAYBOOK: ${playbook}"

  ansible-playbook "${playbook}" 2>&1 | tee -a "${LOG_FILE}"

  log "PASS optional: ${title}"
}

restore_baseline() {
  log "START baseline restore"

  if [ -f "playbooks/12b-restore-path-costs.yml" ]; then
    ansible-playbook playbooks/12b-restore-path-costs.yml 2>&1 | tee -a "${LOG_FILE}" || true
  fi

  if [ -f "playbooks/12c-restore-critical-to-path1.yml" ]; then
    ansible-playbook playbooks/12c-restore-critical-to-path1.yml 2>&1 | tee -a "${LOG_FILE}" || true
  fi

  if [ -f "playbooks/14f-verify-go-ebpf-agent-default.yml" ]; then
    log "Default Go eBPF agent verification is available."
  fi

  log "END baseline restore"
}

trap restore_baseline EXIT

log "STABLE_DEMO_START run_id=${RUN_ID}"
log "ROOT_DIR=${ROOT_DIR}"
log "LOG_FILE=${LOG_FILE}"

run_required "playbooks/08-verify-workload-services.yml" "Validate workload services"

run_required "playbooks/10a-ovs-edge-policy-smoke.yml" "Validate OVS edge segmentation policy"

run_optional "playbooks/10b-ovs-edge-overlay-workload-policy.yml" "Validate OVS overlay workload policy"

run_required "playbooks/11d-verify-te-metrics-collector.yml" "Validate TE metrics collector"

run_required "playbooks/12a-verify-te-decision-engine.yml" "Validate TE decision baseline"

run_required "playbooks/12b-verify-critical-path-decision.yml" "Validate degraded critical path decision"

run_required "playbooks/12d-verify-te-actuator.yml" "Validate TE actuator API"

run_required "playbooks/13d-verify-ebpf-collector-integration.yml" "Validate eBPF collector integration"

run_required "playbooks/13e-verify-ebpf-te-correlation.yml" "Validate eBPF and TE correlation"

run_required "playbooks/14b-verify-ebpf-agent-health-api.yml" "Validate eBPF agent health inventory"

run_required "playbooks/14f-verify-go-ebpf-agent-default.yml" "Validate default Go eBPF agent"

run_optional "playbooks/15a-verify-native-go-ebpf-ringbuf-canary.yml" "Validate native Go eBPF ring buffer canary"

log "STABLE_DEMO_PASS run_id=${RUN_ID}"
log "Demo log saved to ${LOG_FILE}"
