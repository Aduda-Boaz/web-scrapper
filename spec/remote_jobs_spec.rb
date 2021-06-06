require_relative 'spec_helper'
require_relative '../lib/remote_jobs'
require_relative '../lib/scraper'
require 'nokogiri'
require 'httparty'

describe '#scraper' do
  subject { Scraper.new }
  it 'checks if page is parsed' do
    expect(subject.send(:parsing_page, 'https://www.indeed.com/viewjob').text.instance_of?(String)).to be_truthy
  end
end
