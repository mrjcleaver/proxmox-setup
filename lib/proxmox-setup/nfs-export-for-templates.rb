include GLI::App

desc 'Mount NFS locations for backups etc.'
arg_name 'Describe arguments to mountnfs here'
command 'mount-nfs' do |c|
  c.flag :ip

  c.action do |global_options,options,args|
    mount_nfs(options)
    puts "mount-nfs command ran"
  end
end


def export_nfs_for_templates
  puts "NFS Exports on your mac"
  run_shell_cmd("cat /etc/exports")
  run_shell_cmd("sudo nfsd checkexports")
  run_shell_cmd("sudo nfsd start")
  run_shell_cmd("sudo nfsd enable")
end


def mount_nfs(options)
  ip = find_pve(options)
  cmd = "pvesh create /storage -server '#{@storageServerIP}' -storage #{@storageName} \
                                  -export #{@exportedMountPoint} \
                                  -content 'images' -type 'nfs' -options 'vers=3'
"
  proxmox_ssh(ip, cmd)

  # http://forum.proxmox.com/threads/20467-pvesh-set-storage-issues?p=104418#post104418
end

def show_mounts()
  run_shell_cmd("showmounts -e")
end
# http://www.serverlab.ca/tutorials/osx/administration-osx/how-to-connect-mac-os-x-to-nfs-shares/
# http://wiki.wdlxtv.com/Sharing_from_OSX includes NFS.prefPane
