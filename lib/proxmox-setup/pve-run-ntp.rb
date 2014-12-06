# http://www.techques.com/question/2-240189/System-time-is-wrong-in-Proxmox-VE-host,-how-can-I-fix-it
# Correct time is a must for a Chef client run to complete.

include GLI::App


desc 'Run NTP on the PVE'
arg_name 'IP'
command 'pve-enable-ntp' do |c|
  c.flag :ip

  c.action do |global_options,options,args|
    pve_enable_ntp(options)
    puts "pve_enable_ntp command ran"
  end
end

#
# What does
#
# /usr/sbin/ntpq -p
# show?
#
# Try doing
#
# sntp -P no -r pool.ntp.org
# to set the time right and do afterwards a
#
# hwclock --systohc
# to write the time to the hardware clock.

def pve_enable_ntp(options)
  vm = find_pve(options)
  proxmox_ssh(vm, "service ntp status")
  proxmox_ssh(vm, "service ntp start")
  # Expect: Starting NTP server: ntpd.
  proxmox_ssh(vm, "service ntp status")
end