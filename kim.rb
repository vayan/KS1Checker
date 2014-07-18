#!/user/bin/ruby -w
# -*- coding: utf-8 -*-

require 'net/http'
require 'openssl'
require 'json'

http = Net::HTTP.new("ws.ovh.com", 443)
http.use_ssl = true
http.read_timeout = 1000

#bad bad
http.verify_mode = OpenSSL::SSL::VERIFY_NONE

response = http.request(Net::HTTP::Get.new("/dedicated/r2/ws.dispatcher/getAvailability2"))

jsonbody = JSON.parse(response.body)["answer"]["availability"]

jsonbody.each do|serv|
  if serv["reference"] == "142sk1"
    puts serv["zones"]

  end
end

#puts(jsonbody["answer"]["__class"])


__END__
