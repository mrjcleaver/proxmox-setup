include GLI::App
require 'proxmox-setup.rb'

desc 'Installs your ssh-key to the root account of the PVE'
arg_name 'Describe arguments to ssh-keys here'
command 'ssh-install-keys'do |c|
  c.flag :vm
  c.flag :ip

  c.action do |global_options,options,args|


    install_ssh_key(options)
    puts "ssh-keys command ran"
  end
end

desc 'ssh to PVE'
arg_name 'Describe arguments to ssh-keys here'
command 'ssh'do |c|
  c.flag :vm
  c.flag :ip

  c.action do |global_options,options,args|


    pve_ssh(options, args)
    puts "ssh command ran"
  end
end

def ct_ssh(options, args)
  ip = find_pve(options)
  # TODO - allow CTID but not VM.
  cli = "ssh root@#{ip} "+args
  puts run_shell_cmd(cli)
end

def ct_scp(options, file, target)
  ip = find_pve(options)
  # TODO - allow CTID but not VM.
  cli = "scp '#{file}' 'root@#{ip}:#{target}'"
  run_shell_cmd(cli)
end

def pve_ssh(options, args)
  ip = find_pve(options)
  cli = "ssh root@#{ip} "+args.join(' ')
  puts run_shell_cmd(cli)
end


def install_ssh_key(options)
  ip = find_pve(options)
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
  cli = "ssh root@#{ip} '"+cmd+"'"
  run_shell_cmd(cli)
end

def proxmox_scp(vm, file, target)
  ip = ensure_got_ip_of_proxmox(vm)
  cli = "scp '#{file}' 'root@#{ip}:#{target}'"
  run_shell_cmd(cli)
end


#Future ideas:
# http://askubuntu.com/questions/246323/why-does-sshs-password-prompt-take-so-long-to-appear
