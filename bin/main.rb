require_relative '../lib/match_info'
require 'colorize'
scraper = Scraper.new('https://www.bbc.com/sport/football/tables')
scraper.begin

def prompt
  puts 'Welcome to the most trusted football information center \n \n'
  puts "To continue \n Press 'y' \n \n"
  puts "To quit \n Type 'q' \n \n"
  loop do
    text_input = gets.chomp.downcase
    if ['y', ''].include?(text_input)
      @page_info += 1
      break
    elsif %w[q].include?(text_input)
      puts 'Thanks for trusting our source!'.blue.bold
      puts 'Thank you for your time!'.green.bold
      exit
    else
      puts "Sorry! Please enter a valid character \n \n!".red.bold
      puts "Press \n 'y' to continue \n \n"
      puts "Type \n 'q' to quit \n \n"
      text_input
    end
    text_input
  end
end

def info
  @scraper = Scraper.new('https://www.bbc.com/sport/football/tables')
  @scraper.begin 
  @max = @scraper.instance_variable_get(:@max)
  @last_page = @scraper.instance_variable_get(:@last_page)
  puts "Get the #{@max} latest scores in #{@last_page} pages".blue.bold.underline
  puts 'Loading....'green.bold
  sleep(0.25)
  @page = 1
  @collect = Page.new(@max, @page)
end

def output
  info
  while @page <= @max
    puts "\t Page Number: #{@page} \n \n"
    sleep 0.25
    @collect.scraper
    list = @collect.instance_variable_get(:@list)
    i = 0
    while i < list.count
      puts "Latest live scores \n \n"
      puts "Match: #{list[i][:match]}".blue.bold
      puts "League: #{list[i][:league]}".green.bold
      puts "Result: #{list[i][:result]}".red.bold
      puts ''
      sleep(0.1)
      i += 1
    end
    prompt
    sleep(0.25)
  end
end
output
