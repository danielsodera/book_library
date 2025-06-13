require './lib/book.rb'
require 'csv'

describe Library do
  let(:library_test) { Library.new('./lib/test_library.csv') }

  describe '#read_csv' do
    it 'adds each row of csv file to library array as a hash object' do
      expect(library_test.library).to eq([
        { title: "The Hobbit", author: "J.R.R. Tolkien", status: "unread", rating: "n/a" }
      ])
    end
  end

  describe '#search_library' do
  end

  describe '#display_book' do
  end

  describe '#delete_book' do 
    
  end


end

describe Book do 
  describe '#book_to_hash' do 
    it 'Adds book details to a hash object' do
      new_book = Book.new(title: 'The Lord of the Rings', author: "J.R.R. Tolkien", status: "unread", rating: "n/a")

      expect(new_book.)
    end 

  end
end