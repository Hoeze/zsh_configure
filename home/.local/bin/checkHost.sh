#!/bin/bash

ip="$1"

lang=C; ssh -n -o BatchMode=yes -o ConnectTimeout=5 -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no $ip -C "echo ok" 2>&1 |grep -v -e "Warning: Permanently added '.*' (.*) to the list of known hosts."

exit 0
