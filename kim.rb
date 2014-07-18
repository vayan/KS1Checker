#!/user/bin/ruby -w
# -*- coding: utf-8 -*-

require 'net/http'
require 'openssl'
require 'json'

@http = Net::HTTP.new("ws.ovh.com", 443)
@http.use_ssl = true
@http.read_timeout = 1000
@http.verify_mode = OpenSSL::SSL::VERIFY_NONE #bad bad

def is_sk1_avlb() 
	puts "Start Checking OVH"
	response = @http.request(Net::HTTP::Get.new("/dedicated/r2/ws.dispatcher/getAvailability2"))
	jsonbody = JSON.parse(response.body)["answer"]["availability"]

	jsonbody.each do|serv|
		if serv["reference"] == "142sk1"
			serv["zones"].each do |sk1|
				puts sk1["zone"] + "is " + sk1["availability"]
				if sk1["availability"] != "unavailable"
					return true
				end
			end
		end
	end
	return false
end

while true 
	if is_sk1_avlb
		puts "OMG" 
	else
		puts "Nope...nothing.."
	end
	sleep(2*60)
end

__END__

