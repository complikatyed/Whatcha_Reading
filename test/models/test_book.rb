require_relative '../test_helper'

  describe ".initialize" do
    it "sets the title attribute" do
      book = Book.new("foo")
      assert_equal "foo", book.title
    end
  end

  describe ".save" do
  	describe "if the model is valid" do
  		let(:book){ Book.new("Guards, Guards") }
  		it "should return true" do
  			assert book.save
  		end
  		it "saves the model to the database" do
  			book.save
  			assert_equal 1, Book.count
  			last_row = Database.execute("SELECT * FROM books")[0]
  			database_title = last_row['title']
  			assert_equal "Guards, Guards", database_title
  		end
  		it "populates the model with id from the database" do
  			book.save
  			last_row = Database.execute("SELECT * FROM books")[0]
  			database_id = last_row['id']
  			assert_equal database_id, book.id
  		end
  	end

  	describe "if the model is invalid" do
  		let(:book){ Book.new("") }
  		it "returns false" do
  			refute book.save
  		end
  		it "does not save the model to the database" do
  			book.save
  			assert_equal 0, Book.count
  		end
  		it "populates the error message" do
  			book.save
  			assert_equal "\"\" is not a valid book title.", book.errors
  		end
  	end
  end

  describe ".valid?" do
  	describe "with valid data" do
  		let(:book){ Book.new("Mort") }
  		it "returns true" do
  			assert book.valid?
  		end
  		it "sets errors to nil" do
  			book.valid?
  			assert book.errors.nil?
  		end
  	end
  	describe "with no title provided" do
  		let(:book){ Book.new(nil) }
  		it "returns false" do
  			refute book.valid?
  		end
  		it "sets the error message" do
  			book.valid?
  			assert_equal "\"\" is not a valid book title.", book.errors
  		end
  	end
  	describe "with empty string title" do
  		let(:book){ Book.new("") }
  		it "returns false" do
  			refute book.valid?
  		end
  		it "sets the error message" do
  			book.valid?
  			assert_equal "\"\" is not a valid book title.", book.errors
  		end
  	end
  	describe "with a previously invalid title" do
  		let(:book){ Book.new("") }
  		before do
  			refute book.valid?
  			book.title = "Carpe Jugulum"
  			assert_equal "Carpe Jugulum", book.title
  		end
  		it "should return true" do
  			assert book.valid?
  		end
  		it "should not return an error message" do
  			book.valid?
  			assert_nil book.errors
  		end
  	end
  end


