require 'rspec'
require_relative '../classroom'

describe Classroom do 
    let(:classroom) { Classroom.new('F1') }
    let(:student) { Student.new("Cake")}

    describe '@initialize' do
        it 'should initialize with a label' do 
            expect(classroom.label).to eq('F1')
        end

        it 'should initialize with an empty student array' do 
            expect(classroom.students).to eq([])
        end 
    end
end