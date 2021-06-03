#!/usr/bin/env ruby
require_relative '../lib/remote_io'

url = 'https://remotive.io/'
new_scrap = Scrap.new(url)

puts new_scrap.welcome
continue = true
while continue
  puts new_scrap.instructions
  print 'Response: '
  option = get.chomp

  case option.to_i
  when 1
    sections = new_scrap.listings
    puts 'There are #{sections.count} remote jobs available'
    sections.each_with_index { |listing, i| puts "#{i + 1}. #{listing}" }
  when 2
    jobs  = new_scrap.job_title
    puts 'There are #{jobs.count} that matches your category:'
    jobs.each_with_index { |jobs, i| puts "#{i + 1}. #{jobs}" }
  when 3
    puts 'All the jobs with URL: \n'
    new_scrap.job_with_url.each do |job_url|
      job_url.each { |job, nurl| puts "#{job} #{nurl} " }
      puts ''
    end
  else
    puts new_scrap.msg_err
  end
  print "\n If you like to continue, press any key, or 'N' to quit"
  if gets.chomp.upcase == 'N'
    continue = false
    puts new_scrap.end_process
  end
end
