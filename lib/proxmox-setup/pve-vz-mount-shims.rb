include GLI::App
long_desc 'For motivation see http://jpmens.net/2012/11/28/bootstrapping-openvz-containers-in-proxmox-ve/'

desc 'Adds a script to each container during mount. Used for e.g. '
arg_name 'Provide folder of scripts '
command 'container-mount' do |c|
  c.flag :ip

  c.action do |global_options,options,args|

    container_mount(options)

    puts "ssh-keys command ran"
  end
end


def container_mount(options)
  vm = find_pve(options)
  nodes_dir ='/etc/pve/nodes/'
  node_names=proxmox_ssh(vm, "ls #{nodes_dir}").chomp()
  # TODO: make this work with multiple names, or even detect them
  open_vz_dir=nodes_dir+node_names+'/openvz/'
  puts open_vz_dir

  ## https://wiki.openvz.org/Man/vzctl.8#ACTION_SCRIPTS
  # These 3 feel like chef erb template files.
  # They need to take the IP of the client
  proxmox_scp(vm, 'postinstall/vps.mount', open_vz_dir+'vps.mount')
  proxmox_scp(vm, 'postinstall/talk-to-ct.sh', open_vz_dir+'talk-to-ct.sh')
  proxmox_scp(vm, 'postinstall/run-in-ct.sh', open_vz_dir+'run-in-ct.sh')

  id_file=ENV['HOME']+"/.ssh/id_rsa.pub"
  proxmox_scp(vm, id_file,open_vz_dir+'id_rsa.pub')

end