require 'json'
require_relative 'person'

class Student < Person
  attr_reader :classroom

  def initialize(classroom, age, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def classroom=(classroom)
    @classroom = classroom
    classroom.add_student(self) unless classroom.student.include?(self)
  end

  def to_h 
    {
      name: name,
      age: age, 
    }
  end
end
