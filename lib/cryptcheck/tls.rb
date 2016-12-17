require 'erb'
require 'parallel'

module CryptCheck
	module Tls
		def self.analyze(host, port)
			::CryptCheck.analyze host, port, TcpServer, Grade
		end

		def self.colorize(cipher)
			colors = case
						 when /^SSL/ =~ cipher then { color: :white, background: :red }
						 when :TLSv1_2 == cipher then { color: :green }
					 end
			cipher.to_s.colorize colors
		end

		def self.key_to_s(key)
			size, color = case key.type
							 when :ecc
								 ["#{key.group.curve_name} #{key.size}", { color: :green }]
							 when :dh
								 [key.size, { color: :yellow }]
							 when :dsa
								 [key.size, { color: :white, background: :red }]
						 end
			"#{key.type.to_s.upcase.colorize color} #{size.to_s.colorize key.status} bits"
		end
	end
end
