# calls the shell script

@vm_to_ip = {}

def register_ip_of_proxmox(vm, ip)
  @vm_to_ip[vm] = ip
end




def scan_for_ip_of_proxmox(vm)
  if @vm_to_ip[vm]
    puts "returning cached"
    return @vm_to_ip[vm]
  else
    ip_of_proxmox_vm = run_shell_cmd("sh ./ip-of-virtualbox.sh #{vm}").to_s
    #puts ip_of_proxmox_vm

    if ip_of_proxmox_vm then
      ip_of_proxmox_vm =~ /IP=(.+?)$/
      ip = $1.to_s
      if ip.include?(".") then
        #puts "ip=#{ip}"
      else
        puts "Couldn't find proxmox vm #{vm} - is it booted?"
        puts run_shell_cmd("VBoxManage list runningvms")
        exit 1
      end
    else
      puts "issue running ip-of-virtualbox.sh"
      exit 1

    end
    register_ip_of_proxmox(vm, ip)
    return ip
  end
end
