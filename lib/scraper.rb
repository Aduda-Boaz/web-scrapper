require 'nokogiri'
require 'watir'
require 'rubocop'


#Scraper class
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

  def pages(parsed_page = nil, matches_list = nil)
    @page = 1
    per_page = matches_list.count
    per_page = 1 if per_page.zero?
    @max = parsed_page.css('h2.rc-NumberOfResultsSection span').text.gsub(/[^\d]/, '').to_i
    @last_page = (@max / per_page)
  end
  
end
