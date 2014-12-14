require 'proxmox-setup/version.rb'

# Add requires for other files you add to your project here, so
# you just need to require this one file

require 'proxmox-setup/config-defaults'
require 'proxmox-setup/pve-findable.rb'
require 'proxmox-setup/pve-check-setup.rb'
require 'proxmox-setup/virtualbox-vm-for-proxmox.rb'
require 'proxmox-setup/ip-of-virtualbox-scan.rb'
require 'proxmox-setup/run-shell-cmds.rb'
require 'proxmox-setup/ssh.rb'
require 'proxmox-setup/nfs-export-for-templates.rb'
require 'proxmox-setup/pve-vz-template-upload.rb'
require 'proxmox-setup/pve-vz-mount-shims.rb'
require 'proxmox-setup/pve-run-ntp'
require 'proxmox-setup/pve-web-browser.rb'

require 'container-installers/chef-server.rb'
