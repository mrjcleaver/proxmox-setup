def container_mount(vm)
  nodes_dir ='/etc/pve/nodes/'
  node_names=proxmox_ssh(vm, "ls #{nodes_dir}").chomp()
  # TODO: make this work with multiple names, or even detect them
  open_vz_dir=nodes_dir+node_names+'/openvz/'
  puts open_vz_dir

  ## https://wiki.openvz.org/Man/vzctl.8#ACTION_SCRIPTS
  proxmox_scp(vm, 'postinstall/vps.mount', open_vz_dir+'vps.mount')
  proxmox_scp(vm, 'postinstall/talk-to-ct.sh', open_vz_dir+'talk-to-ct.sh')
  proxmox_scp(vm, 'postinstall/run-in-ct.sh', open_vz_dir+'run-in-ct.sh')

  id_file=ENV['HOME']+"/.ssh/id_rsa.pub"
  proxmox_scp(vm, id_file,open_vz_dir+'id_rsa.pub')

end