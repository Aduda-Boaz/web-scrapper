require_relative 'spec_helper'
require_relative '../lib/remote_jobs.rb'
require_relative '../lib/scraper.rb'
require 'nokogiri'
require 'httparty'

describe "#scraper" do
  subject { Scraper.new }
  it 'checks if page is parsed' do
    expect(subject.send(:parsing_page, 'https://www.indeed.com/viewjob').text.class == String).to be_truthy
  end
end

describe "#InScrap" do
  let (:url) { 'https://www.indeed.com/jobs?q=Ruby+On+Rails&l=Remote&rbl=Remote&jlid=aaa2b906602aa8f5&sort=date' }
  subject { InScrap.new(url) } 
  it 'creates indeed_jobs.csv at the root when #scrap in invoked' do
    puts "Testing if indeed.com scrapping works"
    subject.scrap
    expect(File.exist?(indeed_jobs.csv)).to be_truthy
  end
end


