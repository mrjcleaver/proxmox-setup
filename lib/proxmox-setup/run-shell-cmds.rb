
def run_shell_cmd(cmd, monitor=@run_shell_cmd_monitor)
  puts "Running: #{cmd}"
  if (monitor != true) then
    filename = @log
    #puts "Output appending to #{filename}"
    File.open(filename,'a') { |f| f.puts Time.now.to_s }
  end

  pipe = IO.popen(cmd, "r+")
  ans = ""
  while (line = pipe.gets)
    ans += line
    if monitor then
      puts ">  "+line  # so you can monitor it
    else
      #IO.append(filename, line)
      File.open(filename,'a') { |f| f.puts line }
    end
  end
  return ans  # to test the output
end

