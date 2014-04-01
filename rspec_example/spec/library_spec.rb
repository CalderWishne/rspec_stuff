require 'spec_helper'

describe "Library object" do
	before :all do
		lib_obj = [
			Book.new("JavaScript: The Good Parts", "Douglas Crockford", :development),
			Book.new("The Lord of the Rings", "J.R.R. Tolkien", :fantasy),
			Book.new("The Selfish Gene", "Richard Dawkins", :science),
			Book.new("Snow Crash", "Neal Stephenson", :science_fiction)
		]
		File.open("books.yml", "w") do |f|
			f.write YAML::dump lib_obj
		end
	end

	before :each do
		@lib = Library.new("books.yml")
	end

	describe "#new" do
		context "with no parameters" do
			it "has no books" do
				lib = Library.new
				lib.should have(0).books
			end
		end
		context "with a yaml file parameter" do
			it "has four books" do
				@lib.should have(4).books
			end
		end
	end

	it "returns all the books in a given cateory" do
		@lib.get_books_in_category(:development).length.should eql 1
	end

	it "saves the library" do
		books = @lib.books.map(&:title)
		@lib.save
		lib2 = Library.new("books.yml")
		books2 = lib2.books.map(&:title)
		books.should eql books2
	end

end