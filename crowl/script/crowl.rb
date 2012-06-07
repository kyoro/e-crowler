require 'net/http'
require 'pp'
require 'digest/sha1'
while true
  urls = Url.where(:executed => false);
  urls.each do |url|
    url.url =~ /https?:\/\/([a-zA-Z0-9\.]*)(\/.*)/
    host = $1
    path = $2
    result = Net::HTTP.get(host, path) 
    list = result.scan(/https?:\/\/[a-zA-Z0-9\.\/-]*\.jpg/)
    list.each do |img_url|
      hash = Digest::SHA1.hexdigest(img_url) 
      img = Image.find_by_hashkey(hash)
      if img.nil?
        com = sprintf("curl -L -o /pub/ero/%s.jpg %s", hash ,img_url)
        system(com)
        img = Image.new
        img.hashkey = hash
        img.save
        p "Fetch " + com
      else
        p "Already fetched." + hash
      end

    end
    url.executed = true
    url.save
  end
  sleep(1)
end
