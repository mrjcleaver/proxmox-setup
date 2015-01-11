include GLI::App
require 'erb'  # http://www.stuartellis.eu/articles/erb/

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

desc 'chefserver-ip - force chef server to use an ip address instead of a host name'
arg_name 'ct'
command 'chefserver-ip' do |c|
  c.flag :ip, :required => true

  c.action do |global_options,options,args|
    puts "#{options}"
    # Your command logic here

    use_ip_for_chef_server(options, args)

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

  chef_pkg = 'chefdk_0.3.5-1_amd64.deb'
  ct_ssh(options, "wget https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/"+chef_pkg)
  ct_ssh(options, "dpkg -i "+chef_pkg)


  ct_ssh(options, 'chef gem install knife-backup')
  ct_ssh(options, "echo 'eval \"$(chef shell-init bash)\"' >> ~/.bash_profile")

  ct_ssh(options, "knife configure initial --defaults -r ''")
end

def use_ip_for_chef_server(options, args)

  ip = options[:ip]
  tmpfile = '/tmp/chef-server.rb'

  list = BindingBasedTemplate.new(ip, ip_template_not_fqdn_erb())
  list.save(tmpfile)

  ct_scp(options, tmpfile, '/etc/chef-server/chef-server.rb')
  ct_ssh(options, "chef-server-ctl reconfigure")
end


class BindingBasedTemplate # http://www.stuartellis.eu/articles/erb/
  include ERB::Util
  attr_accessor :ip

  def initialize(ip, template)
    @ip = ip
    @template = template
  end

  def render()
    ERB.new(@template).result(binding)
  end

  def save(file)
    File.open(file, "w+") do |f|
      f.write(render)
    end
  end

end



def ip_template_not_fqdn_erb
  %q(
    server_name = "<%= ip %>"
    api_fqdn server_name
    nginx['url'] = "https://#{server_name}"
    nginx['server_name'] = server_name
    lb['fqdn'] = server_name
    bookshelf['vip'] = server_name
  )
end