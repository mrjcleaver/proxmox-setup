def upload_templates(vm)
  proxmox_scp(vm, "templates/debchef-7_7.0-i386.tar.gz", "/var/lib/vz/template/cache/")
end


