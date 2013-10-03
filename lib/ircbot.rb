module PMBot
  class Botcore
    require 'cinch'

    def initialize(config = {})
      @bot = Cinch::Bot.new do

      configure do |c|
        c.server = config.server || "HALCYON.IL.US.DAL.NET"
        c.channels = config.channels
        c.nick = config.nick || "PMBOT"
      end

      #various actions dispatched to the bot from IRC
      on :message, "hello" do |m|
        m.reply "How about a touchbase for Milestone #{rand(1..34)} ?"
      end

      # todo, more messages ...

    end #end bot configuration
    end #init

    def solution_that!
      @bot.start
    end
  end #class
end
