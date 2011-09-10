require 'rubygems'
require 'em-websocket'

EventMachine.run do

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen { 
      ws.send "Hello from EventMachine :)"
    }
    
    ws.onclose { puts "Connection closed =/" }
    
    ws.onmessage { |msg| 
      t = Time.now()
      ws.send "#{t.hour}h#{t.min}: #{msg}"
    }
  end
  
end

