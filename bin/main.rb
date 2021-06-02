#!/usr/bin/env ruby

require_relative '../lib/remote_io'

title = <<~ALL

ALL
puts title
puts 'Welcome to the Remote Jobs Information'
puts 'Select what you need (remotive.io)'
text_input = ''

loop do
  text_input = gets.chomp
  break if ['remotive.io'].include?(text_input)

  puts 'Kindly enter the correct choice'
end

site = nil

if text_input == 'remotive.io'
  url = 'https://remotive.io/remote-jobs'
  site = RemotiveScraper.new(url)
  
elsif
  puts 'Welcome to the the web-scraper :)'
  puts 'Search using the key words as follows'
  puts '-----------------------------------------------------------------'
  puts '0:ruby, 1: javascript, 2: ruby-on-rails, 3: reactjs, 4: python, 5: php'
  puts '-----------------------------------------------------------------'
  puts 'Please enter correct entry (eg. 124 for javascript, ruby-on-rails, and python)'

 num = nil

 loop do
   num = gets.chomp.split('').map(&:to_i)
   break if num.all? { |i| i <= 9 && i >= 0 }
     puts 'Kindly enter a valid search key'
   end
   site = RemotiveScraper.new(num) 
 end

 site.scrap
 