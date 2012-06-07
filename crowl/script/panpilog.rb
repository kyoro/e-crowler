require 'net/http'
require 'pp'
require 'digest/sha1'

    result = Net::HTTP.get('panpilog.com', '/index.rdf')
    list = result.scan(/(http:\/\/panpilog\.com\/archives\/.*\.html)/)
    list.each do |txt|
      p txt
      url = Url.find_by_url(txt)
      if url.nil?
        url = Url.new
        url.url = txt
        url.executed = false;
        url.save
      end
    end

