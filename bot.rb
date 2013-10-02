require 'cinch'
require 'optparse'
require 'ostruct'

options = OpenStruct.new
banner = "Usage: bot.rb --channels one,two,three"

OptionParser.new do |opts|
  opts.separator ""
  opts.on("--channels x,y,z", Array, "Example 'list' of channels") do |list|
    options.list = list
  end
end.parse!

if options.list.nil?
  puts "Usage: bot.rb --channels one,two,three"
  exit 0
end

   ## TODO extract into BOT class away from optparse shizzle
bot = Cinch::Bot.new do

  configure do |c|
      c.server = "HALCYON.IL.US.DAL.NET"
      c.channels = options.list
      c.nick = "PMBOT"
  end


  on :message, "hello" do |m|

    m.reply "How about a touchbase for Milestone #{rand(1..34)} ?"

  end
end
bot.start