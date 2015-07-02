module Callbacks

	class CallbackSequence

		def initialize
			@before = [] of -> Bool
			@after  = [] of -> Bool
		end

		def before(before : Proc)
      @before.unshift(before)
      self
    end

    def after(after : Proc)
      @after.push(after)
      self
    end

    def length
    	@before.length+@after.length
    end

    # invokes before callbacks each by one, than run code and invokes after callbacks
		def call(&block)
			result = true
			@before.each do |before_callback| 
				break result = false  unless before_callback.call
			end
			if result
				block.call
        @after.each do |after_callback| 
				  break result = false unless after_callback.call
				end
			end
			result
		end
	end
end


			