module PMBot
  class Botcore
    require 'cinch'

    def initialize(config = OpenStruct.new)
      @bot = Cinch::Bot.new do

      configure do |c|
        c.server = config.server || "HALCYON.IL.US.DAL.NET"
        c.channels = config.channels
        c.nick = config.nick || "PMBOT"
      end

      # todo, factor out the responses from BotCore
      # BotCore should only need to know howto communicate with IRC
      on :message, Botregex.greetings do |m|
        m.reply "Hello this is #{bot.nick}, how about a quick Milestone #{rand(1..34)} touchbase?"
      end

      on :message, Botregex.goodbyes do |m|
        m.reply "Hey thanks for joining us today, looking forward to bringing this one over the finish line"
      end

      #catch all has 1 in 10 chance of randomly saying stuff about your last message
      chances = (1..10).to_a
      on :message do |m|
        m.reply "... .... ok ..." if chances.sample == 1
      end


    end #end bot configuration
    end #init

    def solution_that!
      @bot.start
    end
  end #class

  # serve as interface for regexes when matching against messages
  # maybe todo - bind together match and response in one object
  class Botregex

    class << self
      def greetings
        /hello|hi|yoyos|morning|good morning/
      end


      def goodbyes
        /later|laterz|see ya|bye|goodbye|have a good one/
      end

      def tech_words
        /web|restful|rails|json|api|iOS/
      end
    end
  end  #end class

end #end PMBot Module
