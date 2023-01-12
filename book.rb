require 'json'

class Book
  attr_accessor :title, :author, :id
  attr_reader :rentals

  def initialize(title, author, id = nil)
    @title = title
    @author = author
    @id = id
    @rentals = []
  end

  def add_rentals(rental)
    @rentals << rental
    rental.book = self
  end

  def to_h
    {
      title: title,
      author: author,
      rentals: rentals.map(&:to_h)
    }
  end
end
