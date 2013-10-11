require 'rubygems'
require 'bundler/setup'
require 'foursquare2'

begin
  foursquare = Foursquare2::Client.new(:client_id => ENV['FSQ_CLIENT_ID'], :client_secret => ENV['FSQ_SECRET'])
  tips = foursquare.search_tips(:ll => ENV['LOCATION'], :query => ENV['QUERY'])
  tips.each do |tip|
    venue = tip.venue
    _what = tip.text
    _when = Time.at(tip.createdAt)
    _where = venue.name
    position = venue.location

    puts _what
    puts "At #{_where} (#{position.lat},#{position.lng}) on #{_when}"
  end
  puts "#{tips.length} tips found"
rescue Faraday::Error::ConnectionFailed => ex
  puts ex.message
end

