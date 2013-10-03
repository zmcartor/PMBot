require 'optparse'
require 'ostruct'
require_relative 'lib/ircbot'

options = OpenStruct.new
banner = "Usage: bot.rb --channels one,two,three"

OptionParser.new do |opts|
  opts.separator ""

  options.server = "HALCYON.IL.US.DAL.NET"
  options.nick = "PMBOT"

  opts.on("-c=channel", "--channels x,y,z", Array, "Example 'list' of channels") do |channels|
    options.channels = channels
  end

  opts.on("-s", "--server irc.blah.net", String, "What server?") do |server|
    options.server = server
  end

  opts.on("-n", "--nick Mr.Suit", String, "Bot nickname") do |nick|
    options.nick = nick
  end

end.parse!

PMBot::Botcore.new(options).solution_that!