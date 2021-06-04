#!/usr/bin/env ruby

require_relative '../lib/remote_jobs'

header = <<~WELCOME

WELCOME
puts header
puts 'Welcome to the Web Scraper for Indeed Jobs'
puts 'Would you like to scrap? (indeed)'
input = ''

web = nil

loop do
  input = gets.chomp
  break if ['indeed'].include?(input)

  puts 'Sorry! Please enter a valid selection'
end

if input == 'indeed'
  url = 'https://www.indeed.com/jobs?q=Ruby+On+Rails&l=Remote&rbl=Remote&jlid=aaa2b906602aa8f5&sort=date'

  web = InScrap.new(url)
else
  puts 'Welcome to webscraper for indeed.com :)'
  puts 'The search keywords are as followed'
  puts '-----------------------------------------------------------------'
  puts '0:ruby-on-rails'
  puts '-----------------------------------------------------------------'
  puts 'Please enter correct combination from above list (eg. 0 for ruby-on-rails)'

  num = nil

  loop do
    num = gets.chomp.split('').map(&to_i)
    break if num.all? { |i| i <= 7 && i >= 0 }

    puts 'Sorry! Please enter a valid search entry'
  end
end

web.scrap
