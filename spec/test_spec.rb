require_relative '../lib/scraper'

describe 'Scraper' do
  let(:scraper) { Scraper.new('https://www.bbc.com/sport/football/tables') }

  describe '#begin' do
    it 'returns the begin method with true' do
      allow(scraper).to receive(:begin).and_return(true)
      expect(scraper.begin).to eql(true)
    end
    it 'returns the begin method with false' do
      allow(scraper).to receive(:begin).and_return(true)
      expect(scraper.begin).to eql(false)
    end
  end

  describe '#pages' do
    it 'private method pages to return true with true value' do
      allow_any_instance_of(Scraper).to receive(:pages).and_return(true)
      expect(scraper.pages).to eql(true)
    end
    it 'private method pages to return false with true value' do
      allow_any_instance_of(Scraper).to receive(:pages).and_return(true)
      expect(scraper.pages).to eql(false)
    end
  end
end
