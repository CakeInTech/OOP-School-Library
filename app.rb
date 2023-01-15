require 'json'
require 'fileutils'
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
    load_data
  end

  def start
    puts 'Welcome to the Library System!'
    list_of_options
    save_data
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
    if @people.empty?
      puts 'No people found'
      return
    end
    @people.each do |person|
      next if person.nil?

      puts "Name: #{person.name}, Age: #{person.age}, ID: #{person.id}"
    end
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    person_type = gets.chomp
    case person_type
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'That is not a valid input'
      create_person
    end
  end

  def create_student
    student_attributes = yoink_student_attributes
    student = Student.new(nil, student_attributes[:age], student_attributes[:name],
                          student_attributes[:parent_permission])
    people << student
    puts 'Person(student) Created successfully'
  end

  def create_teacher
    teacher_attributes = yoink_teacher_attributes
    teacher = Teacher.new(teacher_attributes[:age], teacher_attributes[:specialization], teacher_attributes[:name])
    people << teacher
    puts 'Person(Teacher) created successfully'
  end

  def create_book
    book_attributes = yoink_book_attributes
    book = Book.new(book_attributes[:title], book_attributes[:author])
    books << book
    puts 'Book created!'
  end

  ##### Book renting
  def create_rental
    book = select_book
    person = select_person
    puts 'Date:'
    date = gets.chomp
    rental = Rental.new(date, person, book)
    @rentals << rental
    puts 'Rental created successfully!'
  end

  def select_book
    puts 'Select a book from the following list by number'
    @books.each_with_index do |book, index|
      puts "#{index} Title: #{book.title}, Author: #{book.author}"
    end
    puts 'Book number:'
    book_index = gets.chomp.to_i
    @books[book_index]
  end

  def select_person
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index} [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts 'Person number:'
    person_index = gets.chomp.to_i
    @people[person_index]
  end

  def list_rental_for_person
    id = yoink_id
    puts 'Rentals:'
    @rentals.each do |rental|
      if rental&.person && rental.person.id.to_i == id.to_i
        puts "    "
        puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
        puts "    "
        break
      end
    end
  end

  def save_data
    File.write('books.json', @books.map(&:to_h).to_json)
    File.write('rentals.json', @rentals.map(&:to_h).to_json)
    File.write('people.json', @people.map(&:to_h).to_json)
  end

  def load_data
    @books = load_books
    @people = load_people
    @rentals = load_rentals
  end

  def load_books
    books = []
    books_data = read_and_parse_json_file('books.json')
    books_data.each do |book_data|
      book = Book.new(book_data['title'], book_data['author'])
      books << book
    end
    books
  end

  def load_people
    people = []
    people_data = read_and_parse_json_file('people.json')
    people_data.each do |person_data|
      person = Person.new(person_data['age'], person_data['name'])
      people << person
    end
    people
  end

  def load_rentals
    rentals = []
    rentals_data = read_and_parse_json_file('rentals.json')
    rentals_data.each do |rental|
      date = rental['date']
      person = @people.find { |p| p.name == rental['person'] }
      book = @books.find { |b| b.title == rental['book'] }
      rentals << Rental.new(date, person, book)
    end
    rentals
  end

  def read_and_parse_json_file(file_name)
    JSON.parse(File.read(file_name))
  rescue StandardError
    puts "#{file_name} file not found"
  end
  #######  Attributes for the methods

  private

  def yoink_student_attributes
    puts 'Age'
    age = gets.chomp
    puts 'Name:'
    name = gets.chomp
    puts 'Has parent permission? [Y/N]'
    parent_permission = gets.chomp
    { age: age, name: name, parent_permission: parent_permission.downcase == 'y' }
  end

  def yoink_teacher_attributes
    puts 'Age:'
    age = gets.chomp
    puts 'Specialization:'
    specialization = gets.chomp
    puts 'Name:'
    name = gets.chomp
    { age: age, specialization: specialization, name: name }
  end

  def yoink_book_attributes
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp
    { title: title, author: author }
  end

  def yoink_id
    puts 'Enter the ID:'
    gets.chomp
  end
end
