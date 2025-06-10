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

#current progress 
#day 1 
#added a Library class, initalized a library array to hold all book data 
#defined a readCsv method that succesfully adds the CSV content to an object (array of hashes) 
#defined a start_program method to add the first inital steps of the program 
#defined method view_books, which allows you too see books 
#issue, books are currently displayed through book[0] which is the first column. We want to be able to access each individual book by name if needed.

#day 2
#changed readCSV to use a foreach that adds the headers as first row symbols 
#program now writes back (saves) a new csv file to local directory with #save_csv method
#asks user to write a name for the new csv file before saving 
#adds safety for if user writes an option outside of (1-6)
#nextsteps: Before this gets too big, move it to visual studio to commit properly and add testing for each method 
#tests for: read_csv, start_program, view_books, save_csv


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
		puts "\n1. View all books \n2. Add a new book \n3. Filter by status \n4. Update a book \n5. Delete a book \n6. Exit"
		@options = ["1", "2", "3", "4", "5", "6"]

		puts "\nChoose an option (1-6): "
		@choice = gets.chomp

		until @options.any?(@choice) 
			puts "please choose a number, 1-6 from the list of options stated above:"
			@choice = gets.chomp
		end
		@choice
	end

	def view_books 
		library.each do |book|
			puts "\n#{book[:title]} by #{book[:author]} \nrating: #{book[:rating]} - #{book[:status]}"
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


