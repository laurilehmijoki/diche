require 'rubygems'
require 'em-websocket'

$sockets = []
Thread.new do
  EventMachine.run {

    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8888) do |socket|
        socket.onopen {
          $sockets << socket
        }

        socket.onclose {
          $sockets.delete socket
        }
    end
  }
end

Thread.new do
  require 'json'
  require File.dirname(__FILE__)+"/../common/database"
  begin
    interval = 5
    last_run = Time.new + interval
    while true
      sleep(interval)
      logs = Database.new.load_url_logs(last_run)
      puts "Discovered #{logs.length} new log entries from the database. Sending to #{$sockets.length} clients..." unless logs.empty?
      $sockets.each do |socket| 
        socket.send(logs.to_json) unless logs.empty?
      end
      last_run = Time.new
    end
  rescue Exception => e
    puts "Encountered a problem: #{e.message}"
  end
end

sleep
