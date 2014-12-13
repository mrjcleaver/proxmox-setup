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
end


