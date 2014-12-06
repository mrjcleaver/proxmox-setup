#!/bin/bash

sleep 10 # hoping it will boot by then

id_file=/etc/pve/nodes/proxmox-mm/openvz/id_rsa.pub
cat $id_file | vzctl exec ${VEID} "mkdir /root/.ssh; cat - > /root/.ssh/authorized_keys"
# Add to /etc/hosts.allow
# sshd: 10.0.1.2
vzctl exec ${VEID} "grep 10.0.1.2 /etc/hosts.allow || echo 'sshd: 10.0.1.2' >> /etc/hosts.allow"

/usr/sbin/vzctl runscript ${VEID} /etc/pve/nodes/proxmox-mm/openvz/run-in-ct.sh
