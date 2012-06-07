require 'net/http'
require 'pp'
require 'digest/sha1'

    result = Net::HTTP.get('minkch.com', '/index.rdf')
    list = result.scan(/(http:\/\/minkch\.com\/archives.*\.html)/)
    list.each do |txt|
      url = Url.find_by_url(txt)
      if url.nil?
        url = Url.new
        url.url = txt
        url.executed = false;
        url.save
      end
    end

