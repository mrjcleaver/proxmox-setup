include GLI::App

require 'proxmox-setup.rb'

desc 'Upload OpenVZ template from templates/ to your PVE''s Open VZ template folder'
command 'upload-templates' do |c|
  c.flag :ip

  c.action do |global_options,options,args|
    upload_templates(options)
    puts "uploadtemplates command ran"
  end
end

def upload_templates(options)
  vm = find_pve(options)
  proxmox_scp(vm, @company_vz_template, @open_vz_template_cache )
  proxmox_ssh(vm, "cd /var/lib/vz/template/iso && wget http://releases.ubuntu.com/12.04.5/ubuntu-12.04.5-server-amd64.iso")
  proxmox_ssh(vm, "cd /var/lib/vz/template/cache && wget http://download.openvz.org/template/precreated/ubuntu-12.04-x86_64-minimal.tar.gz")
  #http://download.openvz.org/template/precreated/
end


# http://www.geektoolbox.fr/144/linux-debian-ubuntu-doc/presentation-de-openvz/