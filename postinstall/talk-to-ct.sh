#!/bin/bash

sleep 10

/usr/sbin/vzctl runscript ${VEID} /etc/pve/nodes/proxmox/openvz/run-in-ct
