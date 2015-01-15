include GLI::App

desc 'Find the pve based on either --ip, --vm or ENV[PVE]'

command 'find-pve' do |c|
  c.flag :ip
  c.flag :vm

  c.action do |global_options,options,args|
    puts find_pve(options)
  end
end


def find_pve(options)
  if options[:ip] then
    return options[:ip]
  end

  if (options[:vm]) then
    return ensure_got_ip_of_proxmox(options[:vm])
  end

  env_pve = env_pve_value()
  if (env_pve)
    return env_pve
  end
  raise 'You must specify either export $PVE or call with --vm or --ip (export PVE=https://yourserverip:8006)'

  return ip
end

def env_pve_value
  # TODO: make this more sophisticated
  if ENV['PVE'] then
    ENV['PVE'] =~ /https\:\/\/(.+)(\:8006)/
    ip = $1.to_s
    #puts 'Found PVE in ENV ($PVE):'+ip
    return ip # return the IP out of PVE, might need to take account of PVE_NODE_NAME
  else
    return nil
  end
end

def ensure_got_ip_of_proxmox(vm_or_ip)
  if (!vm_or_ip.include?('.'))
    puts "Wasn't passed an IP, figuring out from #{vm_or_ip}"
  else
    ip=vm_or_ip
    puts "IP=#{ip}"
    return ip
  end
  ip = scan_for_ip_of_proxmox(vm_or_ip)
  if (!ip.include?('.'))
    puts "Didn't get an IP for #{vm_or_ip}, aborting"
    exit 1
  else
    puts "IP=#{ip}"
  end
end


## previous implementation.
def ip_for_vm_old(callthis)
  if (options[:ip])
    callthis.call(options[:ip])
  else
    if (!options[:vm])

    end
    ip = ensure_got_ip_of_proxmox(options[:vm])
    if (ip)
      callthis(ip)
    else
      raise "No valid IP address findable for "+options[:vm]
    end
  end
end