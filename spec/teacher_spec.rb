require 'rspec'
require_relative '../teacher'

describe Teacher do 
    let(:teacher) { Teacher.new(28, 'Math', 'Harrison Njuguna') }

    it 'is a subclass of Person ' do
        expect(teacher).to be_a(Person)
    end

    it 'has a name attribute' do 
        expect(teacher.name).to eq('Harrison Njuguna')
    end

    it 'has a age attrubute' do 
        expect(teacher.age).to eq(28)
    end
end