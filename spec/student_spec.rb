require 'rspec'
require_relative '../student'


describe Student do
  let(:classroom) { double('classroom') }
  let(:student) { Student.new(18, classroom, 'John Doe', true) }

  describe '#initialize' do
    it 'sets the classroom' do
      expect(student.classroom).to eq(classroom)
    end
  end

  describe '#play_hooky' do
    it 'returns the string "¯\(ツ)/¯"' do
      expect(student.play_hooky).to eq('¯\(ツ)/¯')
    end
  end
end
