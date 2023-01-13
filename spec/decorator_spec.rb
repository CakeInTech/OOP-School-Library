require 'rspec'
require_relative '../decorator'

describe Decorator do
    let(:nameable) { double('nameable') }
    let(:decorator) { Decorator.new(nameable) }
  
    describe '#initialize' do
      it 'sets the nameable' do
        expect(decorator.nameable).to eq(nameable)
      end
    end
  
    describe '#correct_name' do
      it 'delegates to the nameable' do
        expect(nameable).to receive(:correct_name)
        decorator.correct_name
      end
    end
end
  
