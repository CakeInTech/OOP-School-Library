require_relative 'app'

def list_of_options
  puts 'choose an option from the following list:'
  puts '1. List all books'
  puts '2. List all people'
  puts '3. Create a person (teacher or student)'
  puts '4. Create a book'
  puts '5. Create a rental'
  puts '6. List all rentals for a given person id'
  puts '7. Exit'
  option_integer = gets.chomp.to_i
  options(option_integer)
  extras(option_integer)
end

def options(option)
  case option
  when 1
    list_all_books
  when 2
    list_all_people
  when 3
    create_person
  when 4
    create_book
  when 5
    create_rental
  when 6
    list_rental_for_person
  end
end

def extras(option)
  case option
  when 7
    puts 'Thank you for using the Library System. Goodbye!'
  else
    list_of_options
  end
end

def main
  app = App.new
  app.start
end

main
