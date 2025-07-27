#!/bin/bash

# Set the namespace
NAMESPACE="kimi-k2-instruct"
# NAMESPACE="sglang-pddev"

# Determine if we need to use sudo with kubectl
if [ "$(id -u)" -eq 0 ]; then
    KUBECTL_CMD="kubectl"
else
    KUBECTL_CMD="sudo kubectl"
fi

# Get pod-to-node mapping with IP using JSON output
$KUBECTL_CMD get pods -n $NAMESPACE -o json | \
jq -r '.items[] | "\(.metadata.name)\t\(.spec.nodeName)\t\(.status.hostIP)"' | \
column -t -s $'\t' | \
awk 'BEGIN {printf "%-40s %-20s %-15s\n", "POD_NAME", "NODE", "NODE_IP"; 
            print "======================================== ==================== ==============="} 
     {printf "%-40s %-20s %-15s\n", $1, $2, $3}'