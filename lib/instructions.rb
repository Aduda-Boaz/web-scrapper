class InsScrap
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def welcome
    puts '\n Welcome to the scrapper. All info are scraped from #{@url}'
  end

  def instructions
    <<-INS
    Enter:
    1 to scrap the remote jobs.
    2 to get the jobs with title listed.
    3 to scrap the listed remote jobs with their URL.
    ...any other key to EXIT: \n
    INS
  end

  def end_process
    puts 'Thank you for trusting the application'
  end

  def msg_err
    puts 'Sorry, kindly make the right selection'
  end
end