require './lib/book.rb'
require 'csv'

describe Library do
  subject { Library.new('./lib/test_library.csv') }
  let(:book) { { title: "The Hobbit", author: "J.R.R. Tolkien", status: "unread", rating: "n/a" } }

  describe '#read_csv' do
    it 'adds each row of csv file to library array as a hash object' do
      expect(subject.library).to eq([book])
    end
  end

  describe '#search_library' do
      #yet to test
  end

  describe '#add_new_book' do
  end

  describe '#update_book' do 
    
  end

  describe '#display_book' do
    it "outputs a book in a specific string format" do 
        expect(subject.display_book(book)).to eql("\nThe Hobbit by J.R.R. Tolkien \nunread - rating: n/a")
    end
  end

  describe '#delete_book' do 
    it "removes book from library hash" do 
      subject.delete_book(book)
      expect(subject.library).to be_empty
    end
  end

  describe '#save_csv' do 
    it "saves a csv file in the same directory" do 
      new_library = "test_new_csv_file"
      file_path = "./#{new_library}.csv"
      subject.save_csv(new_library)

      expect(File.exist?(file_path)).to be true

      File.delete(file_path) if File.exist?(file_path)
    end
  end


end

describe Book do 
  describe '#book_to_hash' do 
    it 'Adds book details to a hash object' do
      new_book = Book.new(title: 'The Lord of the Rings', author: "J.R.R. Tolkien", status: "unread", rating: "n/a")

      expect(new_book.book_to_hash).to eql({title: 'The Lord of the Rings', author: "J.R.R. Tolkien", status: "unread", rating: "n/a"})
    end 

  end
end