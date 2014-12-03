#!/bin/bash

sleep 10 # hoping it will boot by then

id_file=/etc/pve/nodes/proxmox-mm/openvz/id_rsa.pub
cat $id_file | vzctl exec ${VEID} "mkdir /root/.ssh; cat - > /root/.ssh/authorized_keys"


/usr/sbin/vzctl runscript ${VEID} /etc/pve/nodes/proxmox-mm/openvz/run-in-ct.sh
