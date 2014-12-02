def ensure_got_ip_of_proxmox(vm_or_ip)
  if (!vm_or_ip.include?('.'))
    puts "Didn't get an IP, getting from #{vm}"
  else
    ip=vm_or_ip
    puts "IP=#{ip}"
    return ip
  end
  ip = get_ip_of_proxmox(vm)
  if (!ip.include?('.'))
    puts "Didn't get an IP for #{vm}, aborting"
    exit 1
  else
    puts "IP=#{ip}"
  end
end

def install_ssh_key(ip)
  ensure_got_ask_pass()
  #http://www.noah.org/wiki/Category:SSH
  ssh_opts = '-o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -o LogLevel=ERROR -o BatchMode=no  -o ConnectTimeout=10'
  ans = run_shell_cmd("ssh-copy-id #{ssh_opts} root\@#{ip} 2>&1")
  puts ans
  if ans.include?("denied")
    raise "FAILED - please ssh-copy-id root\@#{ip} yourself"
  end
end

def ensure_got_ask_pass()
  if !File.exist?("/usr/libexec/ssh-askpass")
    puts "No ssh-askpass"
    puts "Install from https://github.com/markcarver/mac-ssh-askpass"
    exit 1
  end
end

def proxmox_ssh(vm, cmd)
  ip = ensure_got_ip_of_proxmox(vm)
  cli = "ssh root@#{ip} "+cmd
  run_shell_cmd(cli)
end

def proxmox_scp(vm, file, target)
  ip = ensure_got_ip_of_proxmox(vm)
  cli = "scp '#{file}' 'root@#{ip}:#{target}'"
  run_shell_cmd(cli)
end