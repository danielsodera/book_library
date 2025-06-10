#Interface goal 
# Welcome to your Book Tracker 📖

# 1. View all books
# 2. Add a new book
# 3. Filter by status
# 4. Update a book
# 5. Delete a book
# 6. Exit

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
			library << row
		end
	end

	def start_program
		puts "Welcome to your Book Tracker 📖"
		puts "\n1. View all books \n2. Add a new book \n3. Show all unread books \n4. Update a book \n5. Delete a book \n6. Export libary to csv"
		@options = ["1", "2", "3", "4", "5", "6"]

		puts "\nChoose an option (1-6): "
		@choice = gets.chomp

		until @options.any?(@choice) 
			puts "please choose a number, 1-6 from the list of options stated above:"
			@choice = gets.chomp
		end

		case @choice
		when "1"
			self.view_books
		when "2"
			#add new book 
		when "3"
			self.show_unread
		when "4"
			#update a book 
		when "5"
			#delete a book 
		when "6"
			self.save_csv
		end


	end

	def view_books 
		library.each do |book|
			puts "\n#{book[:title]} by #{book[:author]} \nrating: #{book[:rating]} - #{book[:status]}"
		end
	end

	def show_unread
		library.each do |book|
			if book[:status] == "unread"
				puts "\n#{book[:title]} by #{book[:author]} \nrating: #{book[:rating]} - #{book[:status]}"
			end 
		end
	end

	def save_csv
		puts "Please enter a name for the new library: "
		new_library = gets.chomp

		begin
			CSV.open("#{new_library}.csv", "wb") do |csv|
				csv << library.first.headers
				library.each do |row|
					csv << row
				end
				puts "saved!"
			end 
		rescue Exception => e 
			puts "Unable to save file, error: #{e}"
		end
	end

end









test = Library.new("library.csv")
test.start_program

#test.save_csv


