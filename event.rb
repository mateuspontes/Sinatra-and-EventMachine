require 'rubygems'
require 'em-websocket'

EventMachine.run do
  
  class ChatChannel < EventMachine::Channel
  end
  
  @channel = ChatChannel.new

  EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080) do |ws|
    ws.onopen { 
      @sid = @channel.subscribe { |msg| ws.send msg }
      ws.send("Welcome from EventMachine WebSocket :)")
      
      ws.onmessage { |msg| 
        t = Time.now()
        @channel.push "#{t.hour}h#{t.min} - Mateus: #{msg}"
      }  
      
      ws.onclose { 
        @channel.unsubscribe(@sid)
        puts "Connection closed =/"
      }
    }
    
  end
  
end

