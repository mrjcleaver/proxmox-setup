
puts proxmox_ssh(vm, "brctl show")
puts proxmox_ssh(vm, "cat /etc/network/interfaces")
puts proxmox_ssh(vm, "pvesh get nodes/localhost/network/eth0")
#make_single_network_stable_node('proxmox_stable_network')
# You can explore the API documentation at http://pve.proxmox.com/pve2-api-doc/

