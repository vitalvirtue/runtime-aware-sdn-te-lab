#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
cd "${ROOT_DIR}"

echo "== Repository hygiene check =="

echo
echo "== Git status =="
git status --short

echo
echo "== Large files over 5 MB =="
find . \
  -path "./.git" -prune -o \
  -type f -size +5M -print

echo
echo "== Potential secrets =="
grep -RInE \
  "PRIVATE KEY|BEGIN OPENSSH|BEGIN RSA|password:|passwd:|token:|secret:|api_key|apikey|vault_pass" \
  --exclude-dir=.git \
  --exclude-dir=.venv \
  --exclude-dir=venv \
  --exclude-dir=logs \
  --exclude-dir=tmp \
  . || true

echo
echo "== Shell syntax checks =="
while IFS= read -r file; do
  echo "checking ${file}"
  bash -n "${file}"
done < <(find scripts -type f -name "*.sh" | sort)

echo
echo "== Ansible playbook syntax sample =="
for playbook in \
  playbooks/08-verify-workload-services.yml \
  playbooks/10a-ovs-edge-policy-smoke.yml \
  playbooks/11d-verify-te-metrics-collector.yml \
  playbooks/12a-verify-te-decision-engine.yml \
  playbooks/13e-verify-ebpf-te-correlation.yml \
  playbooks/14f-verify-go-ebpf-agent-default.yml
do
  if [ -f "${playbook}" ]; then
    echo "syntax-check ${playbook}"
    ansible-playbook "${playbook}" --syntax-check >/dev/null
  else
    echo "skip missing ${playbook}"
  fi
done

echo
echo "REPO_HYGIENE_CHECK_DONE"
