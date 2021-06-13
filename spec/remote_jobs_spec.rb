require_relative 'spec_helper'
require_relative '../lib/remote_jobs'
require_relative '../lib/scraper'
require 'nokogiri'
require 'httparty'
require 'pp'

describe '#scraper' do
  subject { Scraper.new }
  it 'checks if page is parsed' do
    expect(subject.send(:parsing_page, 'https://www.indeed.com/viewjob').text.instance_of?(String)).to be_truthy
  end

  it 'checks if file is written' do
    subject.write('testing.csv', [1, 2, 3, 4, 5], 'tests')
    expect(File.exist?('testing.csv')).to be_truthy
  end

  it 'checks if the file is written with a false value' do
    subject.write('testing.csv', [1, 2, 3, 4, 5], 'tests')
    expect(File.exist?('testing.csv')).not_to eql(false)
  end
end

describe '#inscrap' do
  let(:url) { 'https://www.indeed.com/jobs?q=Ruby+On+Rails&l=Remote&rbl=Remote&jlid=aaa2b906602aa8f5&sort=date' }

  subject { InScrap.new(url) }

  it 'should create indeed_jobs.csv after #scrap is invoked' do
    puts 'Testing if site scraping works for indeed.com'
    subject.scrap
    expect(File.exist?('indeed_jobs.csv')).to be_truthy
  end

  it 'should check if indeed_jobs.csv is created without false values' do
    puts 'Testing if site scraping works for indeed.com'
    subject.scrap
    expect(File.exist?('indeed_jobs.csv')).not_to eql(false)
  end
end
