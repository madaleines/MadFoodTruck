require 'table_print'

require_relative 'lib/food_truck'
require_relative 'lib/soda_api_wrapper'

DEFAULT_LIMIT = 10

def main(food_truck_tracker)
  welcome
  display_open_trucks(food_truck_tracker)
end

def continue?
  puts "\n**********************************************\n\n"
  print  "Would you like to continue? (Enter 'Y/'y'): "
  user_choice = gets.chomp.downcase
  return user_choice == 'y'
end

def get_trucks_list(food_truck_tracker, offset)
  return food_truck_tracker.get_open_trucks(offset)
end

def display_no_trucks_message
  sleep(0.1)
  puts "\n**********************************************"
  sleep(0.1)
  puts "There are no trucks available currently\n\n\n"
  exit
end

def table_print_list(list)
  tp list, :name, :address
  sleep(0.1)
  puts "\n**********************************************\n"
end

def display_no_remaining_trucks_message
  sleep(0.1)
  puts "\n**********************************************"
  sleep(0.1)
  puts "\nThere are no more trucks available at this time!\n\n\n"
  exit
end

def display_next_ten_message
  puts "=============== HERE'S THE NEXT 10! ===============\n\n"
  sleep(0.1)
end

def display_remaining_options_message
  puts "============= HERE'S THE REMAINING OPTIONS! =============\n\n"
  sleep(0.1)
end

def print_space
  print "\n\n"
end

def display_open_trucks(food_truck_tracker)
  offset = 0

  first_ten_trucks = get_trucks_list(food_truck_tracker, offset)

  display_no_trucks_message if first_ten_trucks.empty?

  table_print_list(first_ten_trucks)

  while continue?
    print_space
    offset += DEFAULT_LIMIT
    next_ten_trucks = get_trucks_list(food_truck_tracker, offset)

    if next_ten_trucks.length == DEFAULT_LIMIT
      display_next_ten_message
    elsif next_ten_trucks.empty?
      display_no_remaining_trucks_message
    else
      display_remaining_options_message
    end

    table_print_list(next_ten_trucks)

  end
  goodbye
end

def goodbye
  puts "\n~*~*~*~~~**BYEEEEEEEE!**~~~*~*~*~\n\n\n"
end

def welcome
  puts "\n~*~*~*~~~**Welcome to The SF Food Truck Info Page!**~~~*~*~*~\n\n\n"
  sleep(0.1)
  puts "=============== HERE'S THE FIRST 10! ===============\n\n"
  sleep(0.1)
end

food_truck_tracker = SodaApiWrapper.new
main(food_truck_tracker)
