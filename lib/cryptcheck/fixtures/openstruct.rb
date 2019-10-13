require 'ostruct'

class OpenStruct
	def self.deep(hash)
		hash = hash.collect do |k, v|
			v = case v
				when Hash
					self.deep v
				else
					v
				end
			[k, v]
		end.to_h
		self.new hash
	end
end
