require_relative '../lib/scraper'

class Page < Scraper
  attr_reader :max, :page

  def initialize(max, page)
    super(max)
    @page = page
  end
  
  def begin
    url = "https://www.bbc.com/sport/football/tables&page=#{@page}&index=prod_all_products_term_optimization"
    content_doc = ::Watir::Browser.new
    content_doc.element(css: 'li.ais-InfiniteHits-item').wait_until(&:present?)
    content_doc = content_doc.element(css: '#rendered-content')
    content_unparsed_page = content_doc.inner_html
    content_parsed_page = Nokogiri::HTML(content_unparsed_page)
    content_parsed_page.css('li.ais-InfiniteHits-item')
  end
  
  def scraper
    @list = []
    content_matches_list = start
    content_matches_list.each do |match_listing|
      matches = [{
        match: match_listing.css('h2.color-primary-text').text
        league_name: match_listing.css('span.league-name').text
        match_result: match_listing.css('div.match-result-row').text
      }]
      @list.push(matches)
    end
    @page += 1
  end 
end
