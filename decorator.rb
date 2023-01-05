require_relative 'nameable'

class Decorator < Nameable
    attr_accessor :nameable

    def initialize(nameable)
      super()
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
        if @nameable.correct_name.length > 10
          super[0..9]
        else
          super
        end
      end
  end
