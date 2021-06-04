require_relative './lib/remote_jobs.rb'
require 'colorize'
scraper = Scraper.new('https://remotive.io/?live_jobs%5Bquery%5D=ruby%20&live_jobs%5Bmenu%5D%5Bcategory%5D=Software%20Development')
scraper.start

def prompt
  puts 'Welcome to the best scraper for ruby development jobs \n \n'
  puts 'To continue, \n press "y" or "Enter" \n \n'
  puts '\n Type "n" or "q" to quit \n \n'

  loop do
    input = gets.chomp
    if ["y", ""].include?(input)
      @page += 1
      break
    elsif %w[n q].include?(input)
      puts 'Thanks for your time'.green.bold
      puts 'Happy to see you again'.blue.bold
      exit
    else
      puts 'Sorry! Please enter a valid choise'.red.bold
      puts 'To continue, \n press "y" or "Enter" \n \n'
      puts '\n Type "n" or "q" to quit \n \n'
      input
    end
    input
  end
end

def get_info
  @scraper = Scraper.new('https://remotive.io/?live_jobs%5Bquery%5D=ruby%20&live_jobs%5Bmenu%5D%5Bcategory%5D=Software%20Development')
  @scraper.start
  @max = @scraper.instance_variable_get(:@max)
  @last_page = @scraper.instance_variable_get(:@last_page)
  puts 'We have #{@max} openings in #{@last_page} \n \n view results \n \n'
  sleep(0.5)
  @page = 1
  @retrieve = Loop.new(@max, @page)
end

def results
  get_info
  while @page <= @max
    puts '\t Page Number: #{@page} \n \n'
    sleep 0.5
    @retrieve.scraper
    list = @retrieve.instance_variable_get(:@list)
    i = 0
    while i < list.count
      puts " Found Ruby jobs \n\n"
      puts " Position: #{list[i][:position]}".blue.bold
      puts " Company: #{list[i][:company]} \n Location: #{list[i][:location]}".red.bold
      puts " Salary: #{list[i][:salary]}".green.bold
      puts " Job link: https://remotive.io#{list[i][:url]}".blue.bold
      puts ''
      sleep(0.1)
      i += 1
    end
    prompt
    sleep(0.5)
  end
end
results
