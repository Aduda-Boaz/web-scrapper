require_relative '../lib/match_info'
require_relative '../lib/scraper'

describe "Page" do
  let(:scraper) { Scraper.new('https://www.bbc.com/sport/football/tables') }
  let(:value) { Page.new(20, 1) }

  describe "#begin" do
    it 'returns the begin method with true value' do
      allow(value).to receive(:start).and_return(true)
      expect(value.start).to eql(true)
    end
    it 'returns the begin method with false value' do
      allow(value).to receive(:start).and_return(true)
      expect(value.start).to eql(false)
    end
  end
  
  describe "#scraper" do
    it 'check the web pages and return match informations' do
      list = [{
        match: 'Manchester City vs Everton',
        league: 'Premier League',
        result: 'Manchester City 5 - 0 Everton'
        url: 'https://www.bbc.com/sport/football/premier-league'
      }]
      allow(value).to receive(:scraper).and_return(list)
      expect(value.scraper).to eql(list)
    end
  end
  
end
