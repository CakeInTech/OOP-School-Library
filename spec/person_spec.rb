require 'rspec'
require_relative '../person'

describe Person do
  let(:person) { Person.new(20, 'John Doe') }
  let(:rental) { double('rental') }

  describe '#initialize' do
    it 'sets the name and age' do
      expect(person.name).to eq('John Doe')
      expect(person.age).to eq(20)
    end

    it 'generates a unique id' do
      expect(person.id).not_to be_nil
    end

    it 'initializes an empty rentals array' do
      expect(person.rentals).to eq([])
    end
  end

  describe '#add_rentals' do
    it 'sets the person on the rental' do
      expect(rental).to receive(:person=).with(person)
      person.add_rentals(rental)
    end
  end

  describe '#correct_name' do
    it 'returns the name of the person' do
      expect(person.correct_name).to eq('John Doe')
    end
  end
end
