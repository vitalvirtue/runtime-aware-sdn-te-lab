#!/usr/bin/env bash
set -euo pipefail

ONOS_HOST="10.60.10.11"
ONOS_USER="onos"
ONOS_PASS="rocks"

apps=(
  "org.onosproject.p4runtime"
  "org.onosproject.drivers.p4runtime"
  "org.onosproject.drivers.bmv2"
)

for app in "${apps[@]}"; do
  echo "Activating $app ..."
  for i in $(seq 1 10); do
    code="$(curl -s -o /tmp/onos-app-activate.out -w "%{http_code}" \
      -u "${ONOS_USER}:${ONOS_PASS}" \
      -X POST "http://${ONOS_HOST}:8181/onos/v1/applications/${app}/active" || true)"

    if [ "$code" = "200" ] || [ "$code" = "204" ]; then
      echo "OK: $app"
      break
    fi

    echo "Attempt $i failed for $app, HTTP=$code"
    cat /tmp/onos-app-activate.out || true
    echo
    sleep 5
  done
done

echo
echo "Current P4-related app states:"
curl -s -u "${ONOS_USER}:${ONOS_PASS}" \
  "http://${ONOS_HOST}:8181/onos/v1/applications" \
| jq -r '.applications[] | select(.name=="org.onosproject.p4runtime" or .name=="org.onosproject.drivers.p4runtime" or .name=="org.onosproject.drivers.bmv2" or .name=="org.onosproject.p4tutorial.pipeconf" or .name=="org.onosproject.p4tutorial.mytunnel") | "\(.name) \(.state)"'
