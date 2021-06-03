require_relative './scraper'
require_reletive './instructions'

# Get the remote jobs from the site
class RemoteJobs < InsScrap
  attr_reader :url

  include Scraper

  def initialize(url)
    @url = url
  end
  
  def listings
    listings_arr = []
    fetch_listings.each { |listing| listings_arr << listing.css('h2.page-content-title').text }
    listings_arr
  end
  
  def remotes_title
    job_title = []
    remotes.each { |job| job_title << job.text }
    job_title
  end

  def listing_with_url
    job_with_url = []
    remotes.each do |job|
      sub_url = job.css('div.list_title a').map { |link| link['href'] }
      job = {
        title: job.text,
        url: @url + sub_url[0]
      }
      job_with_url << job
    end
    job_with_url
  end

  private

  def last_page
    parsed_page(@url)
  end
  
  def remotes
    remotes = []
    fetch_remotes.each do |job|
      job_softwares = job.css('div.list__item')
      job_softwares.each do |softwares|
        remotes << softwares.css('div.list_title')
      end
    end
    remotes
  end

  def fetch_remotes
    last_page.css('div.list')
  end

  def fetch_listings
    last_page.css('section.page-content_container')
  end  
end
