class Hash
	def compact
		self.reject { |_, v| v.nil? }
	end

	def compact!
		self.reject! { |_, v| v.nil? }
	end
end
