def container_mount(vm)

proxmox_scp(vm, 'postinstall/mount.vps', '/etc/pve/nodes/proxmox/openvz/mount.vps')
proxmox_scp(vm, 'postinstall/talk-to-ct.sh', '/etc/pve/nodes/proxmox/openvz/talk-to-ct.sh')
proxmox_scp(vm, 'postinstall/run-in-ct.sh', '/etc/pve/nodes/proxmox/openvz/run-in-ct.sh')
