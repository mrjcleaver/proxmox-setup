#! /bin/sh
if [ -z "$1" ]; then
    echo "Usage: $0 virtualbox-name"
    echo "Searches arp for IP address of vm"
    exit 1
else 
    VM=$1
fi

# http://stackoverflow.com/questions/18396344/how-can-i-script-genymotion-emulator-to-launch-a-given-avd-headless
#VM=6a5d9245-b751-47aa-b38d-989c5f1a9cfb

NETWORK=192.168.1

echo "VM=$VM"
#find mac of vm
#http://stackoverflow.com/questions/10991771/sed-to-insert-colon-in-a-mac-address
# Update arp table
for i in {1..254}; do ping -c 1 $NETWORK.$i 2>&1; done

MAC=`VBoxManage showvminfo "$VM" | grep MAC | awk -F ":" '{print $3}' | cut -c 2-13`
#echo "MAC=$MAC"

MAC=`echo $MAC | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1:/g' -e 's/\(.*\):$/\1/' | tr '[:upper:]' '[:lower:]'`
echo "MAC=$MAC"

# http://schinckel.net/2013/08/
# this at & on is fugly. But it works.
ARP=`arp -a | 
    sed -E 's/:([[:xdigit:]]):/:0\1:/g' | 
    sed -E 's/at (.:)/at 0\1/' | 
    sed -E 's/:(.) on/:0\1 on/'`

# Find IP: substitute vname-mac-addr with your vm's mac address in ':' notation
#echo "$ARP"

LINE=`echo "$ARP" | grep $MAC`
IP=`echo "$LINE" | cut -d "(" -f2 | cut -d ")" -f1`

echo "IP=$IP"

if [ -z "$IP" ]; then
  echo "$ARP" >&2
fi