require_relative 'nameable.rb'

class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id, :rentals

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = generate_id
    @name = name
    @age = age
    @parent_permission = parent_permission
    @rentals = []
    super()
  end
  
  def rentals(rental)
    @rentals << rental
    rental.person = self
  end

  def correct_name
    @name
  end

  def can_use_services?
    is_of_age? || @parent_permission
  end

  def generate_id
    @id = rand(1...1000)
  end

  private

  def of_age?
    @age >= 18
  end

end


# person = Person.new(22, 'maximilianus')
  # person.correct_name
  # capitalizedPerson = CapitalizeDecorator.new(person)
  # capitalizedPerson.correct_name
  # capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
  # capitalizedTrimmedPerson.correct_name