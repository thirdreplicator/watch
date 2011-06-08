require 'directory_watcher'
 
command = 'rspec --drb --color spec'
#command = "cucumber --drb -f html -o tmp/cuke.html -f features"

dw = DirectoryWatcher.new '.', :pre_load => true, :scanner => :rev
dw.glob = '**/*.{rb,feature,haml,erb}'
dw.reset true
dw.interval = 1.0
dw.stable = 1.0
system(command)
dw.add_observer do |*args|
  args.each do |event|
    #puts event if event.to_s =~ /stable/
    system(command) if event.to_s =~ /stable/
  end
end
dw.start
gets      # when the user hits "enter" the script will terminate
dw.stop


