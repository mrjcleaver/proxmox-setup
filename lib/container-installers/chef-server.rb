include GLI::App

desc 'chefserver-install - install chefserver inside a container'
arg_name 'ct'
command 'chefserver-install' do |c|
  c.flag :ip, :required => true

  c.action do |global_options,options,args|
    puts "#{options}"
    # Your command logic here

    chef_server_in_container(options, args)

  end
end


def chef_server_in_container(options, args)
  #http://www.ameir.net/blog/archives/59-installing-chef-server-in-an-openvz-container.html

  #ct = options[:ip]
  pkg = 'chef-server_11.0.11-1.ubuntu.12.04_amd64.deb'

  ct_ssh(options, "apt-get update")

  ct_ssh(options, "apt-get install ca-certificates -y")
  ct_ssh(options, "apt-get purge apache2* sendmail* cups* samba*") # remove unnecessary packages
  ct_ssh(options, "rm -v /etc/sysctl.d/10-kernel-hardening.conf")

  ct_ssh(options, "wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/"+pkg)
  ct_ssh(options, "dpkg -i "+pkg)
  ct_ssh(options, "chef-server-ctl reconfigure")
end