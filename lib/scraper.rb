require 'nokogiri'
require 'watir'

class Scraper
  attr_reader :link

  def initialize(link)
    @link = link
  end

  def begin
    url = @link
    browser = ::Watir::Browser.new
    browser.goto(url)
    browser.element(css: 'li.ais-InfiniteHits-item').wait_until(&:present)
    doc = browser.element(css: '#rendered-content')
    html_raw = doc.inner_html
    parsed_page = Nokodiri::HTML(html_raw)
    matches_list = parsed_page.css('div.card-content')
    pages(parsed_page, matches_list)  
  end

  private

  def method_name
    
  end
  
end
