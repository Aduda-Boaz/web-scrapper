require_relative '../lib/scraper'

class Page < Scraper
  attr_reader :max, :page

  def initialize(max, page)
    super(max)
    @page = page
  end
  
  def begin
    content_url = ""
    content_doc = ::Watir::Browser.new
    content_doc.element(css: 'li.ais-InfiniteHits-item').wait_until(&:present?)
    content_doc = content_doc.element(css: '#rendered-content')
    content_unparsed_page = content_doc.inner_html
    content_parsed_page = Nokogiri::HTML(content_unparsed_page)
    content_parsed_page.css('li.ais-InfiniteHits-item')
  end
  
  def scraper
    
  end
  
end