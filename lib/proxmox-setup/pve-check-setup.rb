
include GLI::App

desc 'Check PVE setup'
command 'check-pve' do |c|
  c.flag :ip
  c.flag :vm

  c.action do |global_options,options,args|
    check_pve(options)
  end
end

def check_pve(options)
  vm = find_pve(options)
  puts proxmox_ssh(vm, "brctl show")
  puts proxmox_ssh(vm, "cat /etc/network/interfaces")
  # You can explore pvesh parameters - through the API documentation at http://pve.proxmox.com/pve2-api-doc/
  puts proxmox_ssh(vm, "pvesh get nodes/localhost/network/eth0")
  puts proxmox_ssh(vm, "cat /etc/resolv.conf")
  puts proxmox_ssh(vm, "ping -c 1 download.openvz.org")
end
