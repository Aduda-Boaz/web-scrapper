#!/usr/bin/env ruby

require_relative '../lib/remote_jobs'

header = <<~WELCOME

WELCOME
puts header
puts 'Welcome to the Web Scraper for Indeed Jobs'
puts 'Would you like to scrap? (indeed)'
input = ''

loop do
  input = gets.chomp
  break if ['indeed', 'remote.io'].include?(input)

  puts 'Sorry! Please enter a valid selection: indeed / remote.io'
end

site = nil

case input
when 'indeed'
  url = 'https://www.indeed.com/jobs?q=developer+remote&l=Remote'

  puts 'Welcome to indeed.com scraper:)'
  puts 'See the search key words as follows'
  puts '-----------------------------------------------------------------'
  puts '0:ruby, 1: javascript,2: ruby-on-rails,3: reactjs,4: python'
  puts '-----------------------------------------------------------------'
  puts 'Please enter combination from the list (eg. 124 for javascript, ruby-on-rails, and python)'

  num = nil
  loop do
    num = gets.chomp.split('').map(&:to_i)
    break if num.all? { |i| i <= 5 && i >= 0 }

    puts 'Sorry, please enter a valid combination'
  end

  site = InScrap.new(url)
end

site.scrap
