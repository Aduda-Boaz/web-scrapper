require_relative './scraper'
require 'nokogiri'
require 'httparty'

class InScrap < Scraper
  attr_accessor :url

  def initialize(url)
    @url = url
    @output = ['Title, Company, Location, Summary, URL, Date']
  end

  def scrap
    parsed_page = parsing_page(@url)
    ttl_pages = ttl_pages_finder(parsed_page, 'div.searchCount-a11y-contrast-color')
    pages_append_urls = page_ending_urls(ttl_pages)
    scrap_per_page(pages_append_urls)
    sort_by_dates(@output)
    write('indeed_jobs.csv', @output, 'jobs')
  end

  private

  def ttl_pages_finder(parsed_page, page_css_property)
    parsed_page.css(page_css_property).text[48..50].to_i
  end

  def page_ending_urls(ttl_pages)
    (0..ttl_pages).to_a.select { |i| (i % 10).zero? }
  end

  def add_jobs(jobs_listings)
    jobs_listings.each do |listing|
      title = listing.css('a.jobtitle').text.gsub("\n", '').gsub(',', ' ')
      company = listing.css('span.company').text.gsub("\n", '').gsub(',', ' ')
      location = 'remote' # css is 'span.location' if needed
      summary = listing.css('div.summary').text.gsub("\n", '').gsub(',', ' ')
      key_url = listing.css('a')[0].attributes['href'].value[7..-1]
      url = key_url.start_with?('?jk=') ? "https://www.indeed.com/viewjob#{key_url}" : ''
      date = listing.css('span.date').text.gsub("\n", '')
      @output << "#{title},#{company},#{location},#{summary},#{url},#{date}"
    end
  end

  def scrap_per_page(urls_arr)
    urls_arr.each do |page|
      each_page_url = @url + "&start=#{page}"
      parsed_page = parsing_page(each_page_url)
      jobs_listings = parsed_page.css('div.jobsearch-SerpJobCard')
      add_jobs(jobs_listings)
      puts "#{@output.length - 1} Jobs scraped from indeed.com..."
    end
  end

  def sort_by_dates(arr)
    [arr[0]] + arr[1..-1].sort_by { |str| str.split(',')[-1][0, 2].to_i }
  end
end
