require 'erb'
require 'parallel'

module CryptCheck
	module Tls
		def self.analyze(hostname, port)
			host = Host.new hostname, port
			self.aggregate host
		end

		def self.aggregate(hosts)
			hosts = [hosts] unless hosts.respond_to? :collect
			hosts.inject([]) { |l, h| l + h.to_h }
		end

		def self.key_to_s(key)
			size, color = case key.type
						  when :ecc
							  ["#{key.group.curve_name} #{key.size}", :good]
						  when :rsa
							  [key.size, nil]
						  when :dsa
							  [key.size, :critical]
						  when :dh
							  [key.size, :warning]
						  end
			"#{key.type.to_s.upcase.colorize color} #{size.to_s.colorize key.status} bits"
		end
	end
end
