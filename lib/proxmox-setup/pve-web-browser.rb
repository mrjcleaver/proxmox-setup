
include GLI::App

desc 'Open PVE in browser'
command 'pve-web' do |c|
  c.flag :ip

  c.action do |global_options,options,args|
    open_pve(options)
  end
end

def open_pve(options)
  vm = find_pve(options)
  pve_web = 'https://'+vm+':8006'
  run_shell_cmd('open '+pve_web)
end
