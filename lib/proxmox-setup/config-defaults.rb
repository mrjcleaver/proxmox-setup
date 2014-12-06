def setup_defaults(defaults_file)
  # NOTE! Lots of code also available for inspiration in
  # /Applications/Vagrant/embedded/gems/gems/vagrant-1.6.5/plugins/providers/virtualbox/driver/version_4_3.rb

  # technically the right way to set up defaults is with config[:config_name], but it seems harder to then use.
  @disk_folder="/Volumes/Mavericks\ on\ SSD/VirtualBoxDisksOnSSD"
  @install_iso="proxmox-ve_3.3-a06c9f73-2.iso"
  @hd_on_ssd="on"
  @hd_size_mb="20000" # 10,000 = 10GB
  @ram_mb="3072"

  @wifi_bridge="en1: Wi-Fi (AirPort)"
  @nat_net_cidr="192.168.11.0/24"
  @nat_net_gateway="192.168.11.2"
  @nat_net_dns="192.168.11.3"

  @hostonly_network_ip="192.168.4.1"
  @hostonly_gateway="192.168.4.2"
  @container_network_cidr="192.168.9.0/24"
  @container_network_vmbr_ip="192.168.9.1"

  @storageServerIP = '10.0.1.2'
  @storageName = 'Backups'
  @exportedMountPoint = '/Volumes/Storage/martincleaver/ProxmoxBackups'

  @open_vz_template_cache = '/var/lib/vz/template/cache/'

  if File.file?(defaults_file)
    $: << File.expand_path(Dir.pwd)
    require defaults_file
    # TODO - remove . from the LOAD_PATH
  else
    puts "make your LOCAL OVERRIDING DEFAULTS file #{defaults_file}"
  end
end