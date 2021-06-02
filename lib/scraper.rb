require 'nokogiri'
require 'httparty'


# Scraper class
class Scraper
  def read(file_name, arr, match)
    File.read(file_name, arr.join("\n"))
    puts '#{file_name} created in the root directory with #{arr.length - 1} #{match}.'
  end
  
  private

  def parsing_page(url)
    Nokogiri::HTML(HTTParty.get(url).body)
  end
  
end
