#Book library - allows user to extract a csv of books, search through it, add/update/delete an entry, and extract the library to a new/exisiting csv. 

require 'csv'

class Library 
	attr_accessor :library

	def initialize(file)
		@library = []
		read_csv(file)
	end

	def read_csv(file)
		CSV.foreach(file, headers: true, header_converters: :symbol) do |row|
			library << row.to_h
		end
	end

	def start_program
		puts "Welcome to your Book Tracker 📖"

		loop do 
			puts "-"*20
			puts "Main Menu"
			puts "\n1. View all books \n2. Filter by unread \n3. Find a book \n4. Add a new book \n5. Update a book \n6. Delete a book \n7. Export libary to csv \n8. Exit program"
			menu_choice = get_option
		break if menu_choice == "8"	
			choice(menu_choice)
		end
			puts "Goodbye!"
	end

	def get_option
		options = ["1", "2", "3", "4", "5", "6", "7", "8"]

		print "\nChoose an option (1-8): "
		input = gets.chomp

		until options.any?(input) 
			print "please choose a number, 1-8 from the list of options stated above: "
			input = gets.chomp
		end
		input 
	end

	def choice(input)
		case input
		when "1"
			self.view_books
		when "2"
			self.show_unread
		when "3"
			self.find_book
		when "4"
			self.add_new_book
		when "5"
			self.update_book
		when "6"
			puts "What is the title of the book you want to delete?"
			book = search_library
			self.delete_book(book)
		when "7"
			puts "Please enter a name for the new library:"
			new_library = gets.chomp
			self.save_csv(new_library)
		end
	end

	def view_books 
		library.each do |book|
			puts display_book(book)
		end
	end

	def show_unread
		library.each do |book|
			if book[:status] == "unread"
				puts display_book(book)
			end 
		end
	end

	def search_library
		book = {}
		
		loop do
			input = gets.chomp.downcase
			book = library.find { |book| book[:title].downcase == input }
			break if book 
			puts "could not find book, please search for title again"
		end
		
		book
	end

	def find_book 
		puts "Enter book title..."
		book = search_library
		puts display_book(book)
	end

	def add_new_book
		#method is large, could break this down into smaller methods and keep the begin-rescue clause in this one. 
		#could also add more checks for user input here 
		print "Enter title: "
		title = gets.chomp

		print "Enter author: "
		author = gets.chomp

		print "Enter status (unread/read/reading): "
		status = gets.chomp.downcase

		if status == "read"
			print "how would you rate it out of 10?"
			rating = gets.chomp
		else 
			rating = "n/a"
		end

		begin
			new_book = Book.new(title: title, author: author, status: status, rating: rating)
			library << new_book.add_new_book
			puts "\nAdded book!"
		rescue Exception => e
			puts "Unable to add book to library, error: #{e}"
		end
	end

	def update_book	
		puts "What is the current title of the book you want to update?"
		book = search_library

		puts "What aspect would you like to change? (title, author, status, rating)"
		input = gets.chomp.downcase.to_sym 

		unless input == :title || input == :author || input == :status || input == :rating
			puts "You can only change the title, author, status or rating"
			puts "Please type in title, author, status or rating"
			input = gets.chomp.downcase.to_sym 
		end

		puts "Current data is #{book[input]}"
		print "Enter new #{input.to_s}: "

		new_input = gets.chomp 

		book[input] = new_input 

		puts "Updated entry: #{book[input]}"
	end

	def delete_book(book)
		library.delete(book) 		
	end

	def save_csv(new_library)
		begin
			CSV.open("#{new_library}.csv", "wb") do |csv|
				csv << library.first.keys
				library.each do |row|
					csv << row.values
				end
				puts "saved!"
			end 
		rescue Exception => e 
			puts "Unable to save file, error: #{e}"
		end
	end

	def display_book(book)
			"\n#{book[:title]} by #{book[:author]} \n#{book[:status]} - rating: #{book[:rating]}"
	end

end

class Book 

	attr_accessor :title, :author, :status, :rating
	
	def initialize(title:, author:, status:, rating:)
		@title = title 
		@author = author
		@status = status
		@rating = rating
		
	end	

	def book_to_hash
		 {title: @title, author: @author, status: @status, rating: @rating}
	end

end

# test = Library.new("lib/library.csv")
# test.start_program


