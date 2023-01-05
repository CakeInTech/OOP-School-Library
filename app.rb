require_relative 'rental'
require_relative 'person'
require_relative 'classroom'
require_relative 'book'
require_relative 'student'
require_relative 'teacher'

class App 
    attr_accessor :books, :people, :rentals

    def initialize 
        @books = []
        @people = []
        @rentals = []
    end

    def start 
        puts "Welcome to School Library app!"
        list_of_options
    end
     
    def list_all_books
        if @books.length.positive?
          @books.each do |book|
            puts "Title: #{book.title}, Author: #{book.author}"
          end
        else
          puts 'No books found'
        end
    end

    def list_all_people
        @people.each do |person|
          puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
        end
    end

    def create_person
        puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
        person_type = gets.chomp
        case person_type
        when '1'
          create_a_student
        when '2'
          create_a_teacher
        else
          puts 'That is not a valid input'
          create_a_person
        end
    end

end