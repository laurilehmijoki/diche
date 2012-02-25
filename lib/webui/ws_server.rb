require 'rubygems'
require 'em-websocket'

$sockets = []
Thread.new do
  EventMachine.run {

    EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8888) do |socket|
        socket.onopen {
          socket.send "Connection established"
          $sockets << socket
        }

        socket.onclose {
          $sockets.delete socket
        }
    end
  }
end

Thread.new do
  while true
    sleep(3)
    $sockets.each do |socket| 
      puts "sending"
      socket.send "hello"
    end
  end
  puts "je"
end

sleep
