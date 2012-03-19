worker_processes 2
working_directory "#{File.expand_path(File.dirname(File.dirname(__FILE__)))}"
preload_app true
timeout 30
rails_env = 'production'
listen "#{File.expand_path(File.dirname(File.dirname(__FILE__)))}/tmp/sockets/unicorn.sock", :backlog => 64
pid "#{File.expand_path(File.dirname(File.dirname(__FILE__)))}/tmp/pids/unicorn.pid"
stderr_path "#{File.expand_path(File.dirname(File.dirname(__FILE__)))}/log/unicorn.stderr.log"
stdout_path "#{File.expand_path(File.dirname(File.dirname(__FILE__)))}/log/unicorn.stdout.log"
