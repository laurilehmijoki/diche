require 'rubygems'
require 'em-websocket'

class WSServer
  @@port = 8888
  @@sockets = [] 
  def self.port
    @@port
  end
  def self.run
    event_machine_thread
    check_n_send_thread

    sleep
  end

  private 
  def self.check_n_send_thread
    Thread.new do
      require 'json'
      require File.dirname(__FILE__)+"/../common/database"
      begin
        interval = 5
        last_run = Time.new + interval
        while true
          sleep(interval)
          Region.all_regions.each{ |region|
            logs = Database.new.load_url_logs(last_run, region)
            WSServer.send_logs_to_sockets(logs)
          }
          last_run = Time.new
        end
      rescue Exception => e
        puts "Encountered a problem: #{e.message}"
      end

    end
  end
  def self.event_machine_thread
    Thread.new do
      EventMachine.run {

        EventMachine::WebSocket.start(:host => "0.0.0.0", :port => @@port) do |socket|
        socket.onopen {
          @@sockets << socket
        }

        socket.onclose {
          @@sockets.delete socket
        }
        end
      }
    end
  end
  def self.send_logs_to_sockets(logs)
    puts "Discovered #{logs.length} new log entries from the database. Sending to #{@@sockets.length} clients..." unless logs.empty?
    @@sockets.each do |socket| 
      socket.send(logs.to_json) unless logs.empty?
    end
  end

end
