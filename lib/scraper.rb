require 'nokogiri'
require 'httparty'

class Scraper
  def write(file_name, arr, subject)
    File.write(file_name, arr)
    puts "#{file_name} file created at the root #{arr} #{subject}."
  end

  private

  def parsing_page(url)
    Nokogiri::HTML(HTTParty.get(url).body)
  end
end
