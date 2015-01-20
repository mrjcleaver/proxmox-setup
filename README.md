````
make your LOCAL OVERRIDING DEFAULTS file ./my.defaults.rb (see config-defaults.rb)
Found PVE in ENV ($PVE):10.2.0.24
NAME
    proxmox-setup - Setup Proxmox in various interesting ways, in Virtualbox etc.

    Setup Proxmox in various interesting ways, in Virtualbox etc. Typically: virtualbox-install, virtualbox-start ssh-keys, upload-templates, mount-nfs, container-mount

    REQUIREMENTS - An SSD with at least 10gb of free space - At least 8gb RAM

SYNOPSIS
    proxmox-setup [global options] command [command options] [arguments...]

VERSION
    1.0.0

GLOBAL OPTIONS
    --help          - Show this message
    --ip=ip-address - IP address of your Proxmox server (set with $PVE) (default: none)
    --version       - Display the program version
    --vm=vm         - VBox VM name of your Proxmox server (default: 10.2.0.24)

COMMANDS
    check-pve          - Check PVE setup
    chefserver-install - chefserver-install - install chefserver inside a container
    chefserver-ip      - chefserver-ip - force chef server to use an ip address instead of a host name
    container-mount    - Adds a script to each container during mount. Used for e.g.
    find-pve           - Find the pve based on either --ip, --vm or ENV[PVE]
    help               - Shows a list of commands or help for one command
    mount-nfs          - Mount NFS locations for backups etc.
    pve-enable-ntp     - Run NTP on the PVE
    pve-web            - Open PVE in browser
    ssh                - ssh to PVE
    ssh-install-keys   - Installs your ssh-key to the root account of the PVE
    upload-templates   - Upload OpenVZ template from templates/ to your PVEs Open VZ template folder
    virtualbox-install - create a virtualbox install of Proxmox on this machine
    virtualbox-start   - start the virtualbox containing proxmox

INSTALLATION INSTRUCTIONS

````
git clone https://github.com/mrjcleaver/proxmox-setup.git
cd proxmox-setup
gem install bundler
bundle install
````

This should install all requirements.

Only tested on Mac OS X

````
This utility helps you set up and work with your Proxmox Virtual Environment (PVE).
It can also perform of Proxmox inside Virtualbox, or is also useful if your PVE is already set up.

# CREATING a new PVE inside Virtualbox
    bin/proxmox-setup virtualbox-install --vm px-in-vbox

# returns the IP address
    bin/proxmox-setup find-pve --vm px-in-vbox
(this will tell you PVE=...)

# Passing ip is faster than forcing proxmox-setup to scan for the IP address
# Let's save it so you don't need to keep passing it
    export PVE=https://10.2.0.26:8006


# WORKING WITH YOUR PVE

# We want to be able to ssh in
# This will add your ssh key (using ssh-copy-id) so you can ssh to the PVE
bin/proxmox-setup ssh-install-keys

# Make sure it can talk to the internet, etc.
bin/proxmox-setup check-pve
````
~/SoftwareDevelopment/proxmox-setup 17:15:20 745$ bin/proxmox-setup check-pve
IP=10.2.0.26
Running: ssh root@10.2.0.26 'brctl show'
bridge name	bridge id		STP enabled	interfaces
vmbr0		8000.080027997c21	no		eth0
IP=10.2.0.26
Running: ssh root@10.2.0.26 'cat /etc/network/interfaces'
auto lo
iface lo inet loopback

auto vmbr0
iface vmbr0 inet static
	address 10.2.0.26
	netmask 255.255.255.0
	gateway 10.2.0.1
	bridge_ports eth0
	bridge_stp off
	bridge_fd 0
IP=10.2.0.26
Running: ssh root@10.2.0.26 'pvesh get nodes/localhost/network/eth0'
200 OK
{
   "active" : 1,
   "exists" : 1,
   "method" : "manual",
   "type" : "eth"
}
IP=10.2.0.26
Running: ssh root@10.2.0.26 'cat /etc/resolv.conf'
search local
nameserver 10.2.0.1
IP=10.2.0.26
Running: ssh root@10.2.0.26 'ping -c 1 download.openvz.org'
PING download.openvz.org (199.115.104.11) 56(84) bytes of data.
64 bytes from download.openvz.org (199.115.104.11): icmp_req=1 ttl=53 time=58.6 ms

--- download.openvz.org ping statistics ---
1 packets transmitted, 1 received, 0% packet loss, time 0ms
rtt min/avg/max/mdev = 58.657/58.657/58.657/0.000 ms


````


# Proxmox is just a Debian box, let's take a look
 bin/proxmox-setup ssh uname -a
````
 746$ bin/proxmox-setup ssh uname -a
Running: ssh root@10.2.0.26 uname -a
Linux proxmox 2.6.32-32-pve #1 SMP Thu Aug 21 08:50:19 CEST 2014 x86_64 GNU/Linux
ssh-keys command ran
````

# Now upload your favourite O/S templates  (Storage View > Data Center > proxmox > local > Content)
 bin/proxmox-setup upload-templates # IP address used from $PVE

# Or I guess you could login too
 bin/proxmox-setup ssh vzctl enter 102

# We like Chef. Let's install a chef server for us to use.
# Here IP is the IP of the VM to use
 bin/proxmox-setup chefserver-install --ip=162.250.192.72

# But Chef much prefers it is set up with a DNS name. We don't.
 bin/proxmox-setup chefserver-ip --ip=162.250.192.72


# To run chef-clients, the clock must be correct. All containers will inherit the PVE's time.
 bin/proxmox-setup pve-enable-ntp


# Perhaps you want the Backups feature of PVE to work, and point to an NFS server somewhere on your LAN or laptop
# You set the settings for this in your ./my.defaults.rb file.
 bin/proxmox-setup mount-nfs

# What if you want every container to run a certain script when starting?
bin/proxmox-setup container-mount

# Lastly, we have $PVE set up, here's a trick to open your browser onto your PVE
bin/proxmox-setup open-pve




