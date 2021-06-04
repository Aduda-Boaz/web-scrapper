require_relative './lib/scraper'

class RemoteIo
  attr_reader :max, :page

  def initialize(max, page)
    @max = max
    @page = page
  end

  def start
    iteration_url = 'https://remotive.io/?live_jobs%5Bquery%5D=ruby%20&live_jobs%5Bmenu%5D%5Bcategory%5D=Software%20Development&pn=#{page}'
    iteration_doc = ::OpenURI.open_uri(iteration_url)
    iteration_unparsed_page = iteration_doc.read
    iteration_parsed_page = Nokogiri::HTML(iteration_unparsed_page)
    iteration_parsed_page.css('div.SerpJob-jobCard')
  end

  def scrap
    @list = []
    iteration_rubys_list = start
    iteration_rubys_list.each do |x|
      rubys = { position: x.css('div.rubyposting-title-container').css('a.card-link').text,
               url: x.css('div.rubyposting-title-container').css('a')[0].attributes['href'].value,
               location: x.css('h3.rubyposting-subtitle').css('span.rubyposting-location').text,
               company: x.css('h3.rubyposting-subtitle').css('span.rubyposting-company').text,
               salary: x.css('div.SerpRuby-metaInfo').css('span.rubyposting-salary').text.delete_prefix!('Estimated: ')}
      @list.push(rubys)
    end
    @page += 1
  end
end
