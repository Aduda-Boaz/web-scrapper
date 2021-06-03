require 'nokogiri'
require 'httparty'


# Scraper class
module Scraper
  def parsed_page(url)
    unparsed_page = HTTParty.get(url)
    Nokogiri::HTML(unparsed_page)
  end
end
