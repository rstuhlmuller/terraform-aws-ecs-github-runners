#!/bin/bash

GH_OWNER=$GH_OWNER
GH_TOKEN=$GH_TOKEN
LABELS=$LABELS

RUNNER_SUFFIX=$(cat /dev/urandom | tr -dc 'a-z0-9' | fold -w 5 | head -n 1)
RUNNER_NAME="${RUNNER_PREFIX}-${RUNNER_SUFFIX}"

echo "Configuring runner ${RUNNER_NAME}..."

REG_TOKEN=$(curl -sX POST -H "Accept: application/vnd.github.v3+json" -H "Authorization: token ${GH_TOKEN}" https://api.github.com/orgs/${GH_OWNER}/actions/runners/registration-token | jq .token --raw-output)

cd /home/docker/actions-runner

./config.sh --unattended --url https://github.com/${GH_OWNER} \
    --token ${REG_TOKEN} \
    --name ${RUNNER_NAME} \
    --labels "${LABELS:-default}" \
    --replace

cleanup() {
    echo "Removing runner..."
    ./config.sh remove --unattended --token ${REG_TOKEN}
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

./run.sh & wait $!