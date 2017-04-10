module CryptCheck
	module Tls
		module Grade
			def grade
				@grade ||= calculate_grade
			end

			private
			def calculate_grade
				return :V unless self.valid?
				return :T unless self.trusted?

				states = self.states

				{ critical: :G, error: :F, warning: :E }.each do |type, grade|
					return grade if states[type].any? { |s| s == true }
				end

				{good: %i(D C), great: %i(C B), best: %i(B A)}.each do |type, scores|
					state = states[type]
					return scores.first if state.all? { |s| s != false }
					if state.any? { |s| s == false }
						Logger.info { "Missing #{type} : #{states[type].select { |s| s == false }.collect &:key}" }
						return scores.last
					end
				end

				:'A+'
			end
		end
	end
end
