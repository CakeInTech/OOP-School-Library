require_relative "../book"

describe Book do 
    let(:book) { Book.new('To Kill a Mockingbird', 'Harbor Lee')}

    describe '#initialize' do 
        it 'sets the title and author' do 
            expect(book.title).to eq('To Kill a Mockingbird')
            expect(book.author).to eq('Harbor Lee')
        end

        it 'initializes an empty rentals array' do 
            expect(book.rentals).to eq([])
        end 
    end

    describe '#add_rentals' do 
        let(:rental) { double('rental')}
        it 'sets the book on the rental' do 
            expect(rental).to receive(:book=).with(book)
            book.add_rentals(rental)
        end
    end
end
        