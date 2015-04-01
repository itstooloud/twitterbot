=begin
	
Enter the supplied pin: 5154089
 => #<MicroBlogger:0x007ff48a99b7f0 @client=#<JumpstartAuth::TwitterClient:0x007ff48aadd690 @consumer_key="mJ5otbhPGNoDCgCL7j5g", @consumer_secret="M0XkT6GeBnjxdlWHcSGYX1JutMVS9D5ISlkqRfShg", @access_token="3130951595-UVqarPGgcfjfzMc6VDcXd8bZA02Gqd1jaMStYZm", @access_token_secret="z3bueIbp10E1PaWRzIl7ttywM33KukFkCnnOcygQVhlcQ">> 
	
=end

require 'jumpstart_auth'

class MicroBlogger
  attr_reader :client

  def initialize
    @client = JumpstartAuth.twitter
  
  end

  def tweet(message)
  	if message.length > 140
  		puts "TOO LONG!"
  	else
  		@client.update(message)
  	end
  	
  end

  def run
  	puts "Welcome to Your Twitter Interface!"
  	
  end
end

blogger = MicroBlogger.new
blogger.run
