````
 NAME
    proxmox-setup - Setup Proxmox in various interesting ways, in Virtualbox etc.

    Setup Proxmox in various interesting ways, in Virtualbox etc. Typically: virtualbox-install, virtualbox-start ssh-keys, upload-templates, mount-nfs, container-mount

 SYNOPSIS
    proxmox-setup [global options] command [command options] [arguments...]

 VERSION
    0.0.2

 GLOBAL OPTIONS
    --help          - Show this message
    --ip=ip-address - IP address of your Proxmox server (set with $PVE) (default: none)
    --version       - Display the program version
    --vm=vm         - VBox VM name of your Proxmox server (default: 10.0.1.102)

 COMMANDS
    check-pve          - Check PVE setup
    container-mount    - Adds a script to each container during mount. Used for e.g.
    find-pve           - Find the pve based on either --ip, --vm or ENV[PVE]
    help               - Shows a list of commands or help for one command
    mount-nfs          - Mount NFS locations for backups etc.
    pve-enable-ntp     - Run NTP on the PVE
    pve-web            - Open PVE in browser
    ssh-install-keys   - Installs your ssh-key to the root account of the PVE
    upload-templates   - Upload OpenVZ template from templates/ to your PVEs Open VZ template folder
    virtualbox_install - virtualbox-install - create a virtualbox install of Proxmox on this machine
    virtualbox_start   - virtualbox_start - start the virtualbox
````