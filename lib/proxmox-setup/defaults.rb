def setup_defaults()
  # NOTE! Lots of code also available for inspiration in
  # /Applications/Vagrant/embedded/gems/gems/vagrant-1.6.5/plugins/providers/virtualbox/driver/version_4_3.rb

  @disk_folder="/Volumes/Mavericks\ on\ SSD/VirtualBoxDisksOnSSD"
  #@install_iso="proxmox-ve_3.2-5a885216-5.iso"
  @install_iso="proxmox-ve_3.3-a06c9f73-2.iso"

  @wifi_bridge="en1: Wi-Fi (AirPort)"
  @nat_net_cidr="192.168.11.0/24"
  @nat_net_gateway="192.168.11.2"
  @nat_net_dns="192.168.11.3"

  @hostonly_network_ip="192.168.4.1"
  @hostonly_gateway="192.168.4.2"
  @container_network_cidr="192.168.9.0/24"
  @container_network_vmbr_ip="192.168.9.1"

  defaults_file="my.defaults.rb"
  if File.file?(defaults_file)
    require_relative defaults_file
  else
    puts "make a LOCAL DEFAULTS file #{defaults_file}"
  end
end