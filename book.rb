#Interface goal 
# Welcome to your Book Tracker 📖

# 1. View all books done
# 2. Filter by status done
# 3. Find a book done
# 4. Add a new book done
# 5. Update a book
# 6. Delete a book
# 7. Export library to csv
# 8. Exit done

# Choose an option: 2

# Enter title: The Hobbit
# Enter author: J.R.R. Tolkien
# Enter status (read / reading / to-read): to-read

# Book added successfully!

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
			#update a book
		when "6"
			self.delete_book
		when "7"
			self.save_csv
		end
	end

	def view_books 
		library.each do |book|
			display_book(book)
		end
	end

	def show_unread
		library.each do |book|
			if book[:status] == "unread"
				display_book(book)
			end 
		end
	end

	def search_library
		input = gets.chomp.downcase
		library.find { |book| book[:title].downcase == input }
	end

	def find_book 
		puts "Enter book title..."
		book = search_library

		if book 
			display_book(book)
		else 
			puts "Book not found"
		end
	end

	def add_new_book
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
			new_book = Book.new(title, author, status, rating)
			library << new_book.add_new_book
			puts "Added book!"
		rescue Exception => e
			puts "Unable to add book to library, error: #{e}"
		end
	end

	def delete_book
		puts "What is the title of the book you want to delete?"
		book = search_library
		library.delete(book) 		
	end

	def save_csv
		puts "Please enter a name for the new library: "
		new_library = gets.chomp

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
		puts "\n#{book[:title]} by #{book[:author]} \n#{book[:status]} - rating: #{book[:rating]}"
	end

end

#next step: Create a Book Class, with CRUD - Create, Read, Update, Delete entries 

class Book 

	attr_accessor :title, :author, :status, :rating
	
	def initialize(title, author, status, rating)
		@title = title 
		@author = author
		@status = status
		@rating = rating
		
	end	

	def add_new_book
		 {title: @title, author: @author, status: @status, rating: @rating}
	end

end





test = Library.new("library.csv")
test.start_program

#test.save_csv


