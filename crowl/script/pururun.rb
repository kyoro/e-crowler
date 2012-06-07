require 'net/http'
require 'pp'
require 'digest/sha1'

    result = Net::HTTP.get('blog.livedoor.jp', '/pururungazou/index.rdf')
    list = result.scan(/(http:\/\/blog\.livedoor\.jp\/pururungazou\/archives\/.*\.html)/)
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

