module PMBot
  class Botcore
    require 'cinch'
    def initialize(config = OpenStruct.new, botActions={})
      @bot = Cinch::Bot.new do
        configure do |c|
          c.server = config.server || "HALCYON.IL.US.DAL.NET"
          c.channels = config.channels
          c.nick = config.nick || "PMBOT"
        end

        #override this or simply stub out in test harness ?
        botActions[:message].each do |action|
          on :message, action.regex do |m|
            action.speak m
          end
        end
      end #end bot configuration
    end #init

    def solution_that!
      @bot.start
    end
  end #class

  class BotResponse
    #Tie together regex and responseText objects
    attr_accessor :regex

    def initialize(regex, responseText, random_range=1..1)
      @regex = regex
      @responseText = responseText
      @random_range = random_range
    end

    def speak(channel)
      #some of the functions take the raw message arg as a seed.
      # howto determine whether the responseText messsage needs a param?

      channel.reply @responseText if (@random_range).to_a.sample == 1
    end
  end

# serve as interface for regexes when matching against messages
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

      def git_words
        /pull request|merged|merge|branch|branched/
      end

      def match_any
        //
      end

    end
  end  #end class

  class BotResponseGenerator

    class << self

      @@bot_nick ='Mr.Suit'
      def nick=(nick)
        @@bot_nick = nick
      end

      def touchbase
       "Hello this is #{@@bot_nick}, how about a quick Milestone #{rand(1..34)} touchbase?"
      end

      def farewell
        'Hey thanks for joining us today, looking forward to bringing this one over the finish line'
      end

      def clueless_ok
          "#{random_amount_of_dots} ok"
      end

      def clueless_agreement
        "#{random_amount_of_dots} mm hmm mm #{random_amount_of_dots}"
      end

      def source_control
        'so does he need a rebase?'
      end

      def markov(root_word)
        #todo, markov chained output
      end

      def misinterpreted_hook(message)
        #todo lexically analyze message and create markov off selected noun
      end

      private

      def random_amount_of_dots
        dots = ''
        aggregate_pause = lambda {(1..5.to_a.sample.times{dots.concat('... ')})}
        dots
      end


    end
  end


end #end PMBot Module
