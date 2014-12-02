#! /usr/bin/ruby
#if [ -z "$1" ]; then
#    echo "Usage: $0 virtualbox-name"
#    echo "Searches arp for IP address of vm"
#    exit 1
#else 
    vm=ARGV[0]
#fi

# http://stackoverflow.com/questions/18396344/how-can-i-script-genymotion-emulator-to-launch-a-given-avd-headless
#VM=6a5d9245-b751-47aa-b38d-989c5f1a9cfb

network="192.168.1"

puts "VM=#{vm}"
#find mac of vm
#http://stackoverflow.com/questions/10991771/sed-to-insert-colon-in-a-mac-address
# Update arp table
def update_arp_table(network)
  for i in 1..254 do 
    `ping -c 1 #{network}.#{i} 2&>1;` 
  end
end

mac=`VBoxManage showvminfo '#{vm}' | grep MAC | awk -F ":" '{print $3}' | cut -c 2-13`
#puts "MAC=$mac"

mac=`echo #{mac} | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1:/g' -e 's/\(.*\):$/\1/' | tr '[:upper:]' '[:lower:]'`
puts "MAC=#{mac}"

# http://schinckel.net/2013/08/
# this at & on is fugly. But it works.
arp_cmd="arp -a"

" | sed -E 's/:([[:xdigit:]]):/:0\1:/g' | sed -E 's/at (.:)/at 0\1/' | sed -E 's/:(.) on/:0\1 on/'"
arp=`#{arp_cmd}`

# Find IP: substitute vname-mac-addr with your vm's mac address in ':' notation
#echo "$ARP"
puts arp

#line=`echo "$ARP" | grep $MAC`
#ip=`echo "$LINE" | cut -d "(" -f2 | cut -d ")" -f1`

#puts "IP=$ip"

if ip.nil? then
  puts "$ARP"
end
