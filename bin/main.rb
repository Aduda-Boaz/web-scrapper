require_relative '../lib/page_info'

def prompt
  puts "Welcome to the most trusted football information center \n \n"
  puts "To continue \n Press 'y' \n \n"
  puts "To quit \n Type 'q' \n \n"
  loop do
    text_input = gets.chomp.downcase
    if ['y', ''].include?(text_input)
      @page_info += 1
      break
    elsif %w[q].include?(text_input)
      puts "Thanks for trusting our source!".blue.bold
      puts "Thank you for your time!".green.bold
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
