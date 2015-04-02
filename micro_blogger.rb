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
    command = ""
    while command != "q"
      printf "Enter command : "
      input = gets.chomp
      parts = input.split(" ")
      command = parts[0]
      message = parts[1..-1].join(" ")
      case command
         when 'q' then puts "Goodbye!"
         when 't' then tweet(parts[1..-1].join(" "))
         when 'dm' then dm(parts[1], parts[2..-1].join(" "))
         else
           puts "Sorry, I don't know how to #{command}"
      end

        
    end
  	
  end

  def followers_list
    screen_names = []
    
    @client.followers.each do |follower|
      screen_names << @client.user(follower).screen_name
    end
    screen_names
    
  end

  def spam_my_followers(message)

    spam_list = followers_list
    spam_list.each do |name|
      dm(name, message)
    end

    
  end

  def everyones_last_tweet

    friends = @client.friends
    friends.each do |friend|
      p friend.status.text
    end
    
  end

  def dm(target, message)

    screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
    if screen_names.include? target
      puts "Trying to send #{target} this message: "
      puts message
      message = "d @#{target} #{message}"
      tweet(message)
    else
      puts "That person isn't following you!"
    end

    
  end
end

blogger = MicroBlogger.new
p blogger.followers_list
