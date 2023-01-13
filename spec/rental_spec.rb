require 'rspec'
require_relative '../rental'

describe Rental do
    let(:person) { Person.new("Harrison", "Njuguna") }
    let(:book) { Book.new("How to beocme a polotition", "Harrison") }
    let(:date) { Time.now }
    let(:rental) { Rental.new(date, person, book) }
  
    describe '#initialize' do
      it 'should initialize with a date, person, and book' do
        expect(rental.date).to eq(date)
        expect(rental.person).to eq(person)
        expect(rental.book).to eq(book)
      end
  
      it 'should add the rental to the book and person' do
        expect(book.rentals).to include(rental)
        expect(person.rentals).to include(rental)
      end
    end
  end
  
