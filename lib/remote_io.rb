require_relative './scraper'
require 'nokogiri'
require 'httparty'

class RemoteIo < Scraper
  attr_accessor :url

  def initialize(num_arr)
    @num_arr = num_arr
    @output = ['Title, Company, Requirements, Date, URL']
    @url = 'https://www.remote.io/remote-jobs?s='
    @num_url = %w[ruby javascript ruby-on-rails reactjs python]
  end

  def scrap
    puts "Key selections are #{@num_arr.map { |n| @num_url[n] }.join(' & ')}"
    @url = url_maker(@num_arr)
    page_num = (1..5).to_a # 100 listing limit
    page_scrap(page_num)
    # sorted = [@output[0]] + @output[1..-1].sort_by { |str| str.split(',')[-1][0, 4].to_i }
    write('remote_io.csv', @output, 'jobs')
  end

  private

  def url_maker(ary)
    @url + ary.map { |n| @num_url[n] }.join(',')
  end

  def find_job(ary)
    ary.each do |card|
      title = card.css('h3.job-listing-title').text.delete(',')
      company = card.css('div.job-listing-footer').text.split('  ')[2].delete(',')
      requirements = card.css('div.job-listing-footer').text.split('  ')[4]
      date = card.css('div.job-listing-footer').text.split('  ')[3].delete(',').match(/\d+ \w+ ago/)
      url = "https://www.remote.io/#{card.css('a')[0].attributes['href'].value}"
      @output << "#{title},#{company},#{requirements},#{date},#{url}"
    end
  end

  def page_scrap(page_arr)
    page_arr.each do |page|
      page_url = @url + "&p=#{page}"
      jobs_listings = parsing_page(page_url).css('div.job-listing-description')
      break if jobs_listings.empty?

      find_job(jobs_listings)
      puts "#{@output.length - 1} jobs scraped from remote.io..."
    end
  end
end
