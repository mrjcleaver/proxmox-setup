def export_nfs_for_templates
  puts "NFS Exports on your mac"
  run_shell_cmd("cat /etc/exports")
  run_shell_cmd("sudo nfsd checkexports")
  run_shell_cmd("sudo nfsd start")
  run_shell_cmd("sudo nfsd enable")
end


def mount_nfs(ip)
  storageName = 'Backups'
  exportedMountPoint = '/Volumes/Storage/martincleaver/ProxmoxBackups'
  cmd = "pvesh create /storage -server '#{ip}' -storage #{storageName} \
                                  -export #{exportedMountPoint} \
                                  -content 'images' -type 'nfs'
"
  proxmox_ssh(ip, cmd)
# -options 'vers=3'
  # http://forum.proxmox.com/threads/20467-pvesh-set-storage-issues?p=104418#post104418
end

def show_mounts()
  run_shell_cmd("showmounts -e")
end
# http://www.serverlab.ca/tutorials/osx/administration-osx/how-to-connect-mac-os-x-to-nfs-shares/
# http://wiki.wdlxtv.com/Sharing_from_OSX includes NFS.prefPane
