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
    puts 'Welcome to the Library System!'
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
    if books.empty?
      puts 'No books found'
      return
    end
    books.each { |book| puts "Title: #{book.title}, Author: #{book.author}"}
  end

  def create_person
    puts 'Do you want to create a student (1) or a teacher (2)? [Input the number]:'
    person_type = gets.chomp
    case person_type
    when '1' then
      create_student
    when '2' then
      create_teacher
    else
      puts 'That is not a valid input'
      create_person
    end
  end

  def create_student
    student_attributes = get_student_attributes
    student = Student.new(nil, student_attributes[:age], student_attributes[:name], student_attributes[:parent_permission])
    people << student
    puts "Person(student) Created successfully"
  end

  def create_teacher
    teacher_attributes = get_teacher_attributes
    teacher = Teacher.new(teacher_attributes[:age], teacher_attributes[:specialization], teacher_attributes[:name])
    people << teacherputs 'Person(Teacher) created successfully'
  end

  def create_book
     book_attributes = get_book_attributes
     book = Book.new(book_attributes[:title], book_attributes[:author])
     books << bookputs "Book created!"
  end

  def create_rental
    book = select_book
    person = select_person
    date = get_rental_date
    rentals << Rental.new(date, person, book)
    puts 'Rental created successfully!'
  end


  def list_rental_for_person
   id = get_id
   puts 'Rentals:'
   rentals.select {|rental| rental.person.id == id }.each do |rental| 
    puts "Date: #{rental.date}, Book '#{rental.book.title}' by #{rental.book.author}"
  end
end

#######  Attributes for the methods

private 

def get_student_attributes
  puts 'Age'
  age = gets.chomp
  puts 'Name:'
  name = gets.chomp
  puts 'Has parent permission? [Y/N]'
  parent_permission = gets.chomp
  {age: age, name: name, parent_permission: parent_permission.downcase == 'y'}
end


def get_teacher_attributes
  puts 'Age:'
  age = gets.chomp
  puts 'Specialization:'
  specialization = gets.chomp
  puts 'Name:'
  name = gets.chomp
  {age: age, specialization: specialization, name: name}
end

def get_book_attributes
  puts 'Title:'
  title = gets.chomp
  puts 'Author:'
  author = gets.chomp
  {title: title, author: author }
end

def select_book 
  puts 'Select a book by its ID:'
  id = gets.chomp
  book = books.find {|b| b.id == id}
  if book.nil?
    puts 'Book not found'
    select_book
  else 
    book
  end
end

def get_rental_date 
  puts 'Enter the rental date (YYY-MM-DD): '
  gets.chomp

def get_id 
  puts 'Enter the ID:'
  gets.chomp
end