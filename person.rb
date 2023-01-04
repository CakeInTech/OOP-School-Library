# rubocop:disable all
require 'securerandom'

####  Created a Class Nameable
class Nameable
  def correct_name
    raise NotImplementedError
  end
end

####  Turned my person class to Nameable
class Person < Nameable
  attr_accessor :name, :age
  attr_reader :id

  def initialize(age, name = 'Unknown', parent_permission: true)
    @id = SecureRandom.uuid
    @name = name
    @age = age
    @parent_permission = parent_permission
  end

  def correct_name
    @name
  end

  private

  def of_age?
    @age >= 18
  end

  def generate_id
    @id = rand(1...1000)
  end

  public

  def can_use_services?
    of_age? || @parent_permission
  end
end
class Decorator < Nameable
  def initialize(nameable)
    @nameable = nameable
  end

  def correct_name
    @nameable.correct_name
  end
end

class CapitalizeDecorator < Decorator
  def correct_name
    @nameable.correct_name.capitalize
  end
end

class TrimmerDecorator < Decorator
  def correct_name
    @nameable.correct_name[0..9]
  end
end


# person = Person.new(18, 'test_subject_1')
# person.correct_name
# capitalizedPerson = CapitalizeDecorator.new(person)
# capitalizedPerson.correct_name
# capitalizedTrimmedPerson = TrimmerDecorator.new(capitalizedPerson)
# capitalizedTrimmedPerson.correct_name
