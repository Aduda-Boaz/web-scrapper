require_relative './scraper'
require 'nokogiri'
require 'httparty'

# Get the remote jobs from the site
class RemoteJobs < Scraper
  attr_accessor :url

  def initialize(val_arr)
    @val_arr = val_arr
    @result = ['Job_title, Company, Skills, Posted_time, URL']
    @url = 'https://remotive.io/remote-jobs?s='
    @val_url = %w[ruby ruby-on-rails javascript reactjs python php]
  end

  def start
    # puts "Selected #{@val_arr.map { |n| @val_url[n] }.join(' & ')}"
    @url = url_parser(@val_arr)
    page_start_val = (1..5).to_a
    scraping_page(page_start_val)
    read('remote_io.csv', @result, 'jobs')
  end

  private

  def url_parser(arr)
    @val_url + @val_arr.map { |n| @val_url[n].join(',') }
  end

  def job_list(arr)
    arr.each do |card|
      job_title = card.css('h3.job-listing-title').text.delete(',')
      company = card.css('div.job-listing-footer').text.split('  ')[2].delete(',')
      skills = card.css('div.job-listing-footer').text.split('  ')[4]
      posted_time = card.css('div.job-listing-footer').text.split('  ')[3].delete(',').match(/\d+ \w+ ago/)
      url = 'https://remotive.io/' + card.css('a')[0].attributes['href'].value
      @result << "#{job_title},#{company},#{skills},#{posted_time},#{url}"
    end
  end

  def page_scrap(pg_arr)
    pg_arr.each do |page|
      pg_url = @url + "&p=#{page}"
      job_listings = parsing_page(page_url).css('div.job_listing-description')
      break if job_listings.empty?
      add_job(job_listings)
      puts "#{@result.length - 1} jobs available..."     
    end
  end
  
end
