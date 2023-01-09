require_relative "rental"
require_relative "person"
require_relative "classroom"
require_relative "book"
require_relative "student"
require_relative "teacher"

class App
  attr_accessor :books, :people, :rentals

  def initialize
    @books = []
    @people = []
    @rentals = []
  end

  def start
    puts "Welcome to the Library System!"
    list_of_options
  end

  def list_all_books
    if @books.length.positive?
      @books.each do |book|
        puts "Title: #{book.title}, Author: #{book.author}"
      end
    else
      puts "No books found"
    end
  end

  def list_all_people
    if books.empty?
      puts "No books found"
      return
    end
    books.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
  end

  def create_person
    puts "Do you want to create a student (1) or a teacher (2)? [Input the number]:"
    person_type = gets.chomp
    case person_type
    when "1"
      create_student
    when "2"
      create_teacher
    else
      puts "That is not a valid input"
      create_person
    end
  end

  def create_student
    student_attributes = yoink_student_attributes
    student = Student.new(nil, student_attributes[:age], student_attributes[:name],
      student_attributes[:parent_permission])
    people << student
    puts "Person(student) Created successfully"
  end

  def create_teacher
    teacher_attributes = yoink_teacher_attributes
    teacher = Teacher.new(teacher_attributes[:age], teacher_attributes[:specialization], teacher_attributes[:name])
    people << teacher
    puts "Person(Teacher) created successfully"
  end

  def create_book
    book_attributes = yoink_book_attributes
    book = Book.new(book_attributes[:title], book_attributes[:author])
    books << book
    puts "Book created!"
  end

  ##### Book renting
  def create_rental
    book = select_book
    person = select_person
    puts "Date:"
    date = gets.chomp
    @rentals << Rental.new(date, person, book)
    puts "Rental created successfully!"
  end

  def select_book
    puts "Select a book from the following list by number"
    @books.each_with_index do |book, index|
      puts "#{index} Title: #{book.title}, Author: #{book.author}"
    end
    puts "Book number:"
    book_index = gets.chomp.to_i
    @books[book_index]
  end

  def select_person
    puts "Select a person from the following list by number (not id)"
    @people.each_with_index do |person, index|
      puts "#{index} [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    puts "Person number:"
    person_index = gets.chomp.to_i
    @people[person_index]
  end

  def list_rental_for_person
    id = yoink_id
    puts "Rentals:"
    rentals.select { |rental| rental.person.id == id }.each do |rental|
      puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
    end
  end

  #######  Attributes for the methods

  private

  def yoink_student_attributes
    puts "Age"
    age = gets.chomp
    puts "Name:"
    name = gets.chomp
    puts "Has parent permission? [Y/N]"
    parent_permission = gets.chomp
    {age: age, name: name, parent_permission: parent_permission.downcase == "y"}
  end

  def yoink_teacher_attributes
    puts "Age:"
    age = gets.chomp
    puts "Specialization:"
    specialization = gets.chomp
    puts "Name:"
    name = gets.chomp
    {age: age, specialization: specialization, name: name}
  end

  def yoink_book_attributes
    puts "Title:"
    title = gets.chomp
    puts "Author:"
    author = gets.chomp
    {title: title, author: author}
  end
end

def yoink_id
  puts "Enter the ID:"
  gets.chomp
end
