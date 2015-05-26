require_relative '../test_helper'

describe Book do

	describe "#all" do
		describe "if there are books in the database" do
			before do
				create_book("Sorcery")
				create_book("Equal Rites")
				create_book("Witches Abroad")
			end
			it "populates the returned books' ids" do
				expected_ids = Database.execute("SELECT id FROM books").map{ |row| row['id'] }
				actual_ids = Book.all.map{ |book| book.id }
				assert_equal expected_ids, actual_ids
			end
		end
	end

describe "#find" do
    let(:book){ Book.new(title: "Foundation") }
    before do
      book.save
    end
    describe "if there is a matching book in the database" do
      it "should return the book, populated with id and name" do
        actual = Book.find(book.id)
        assert_equal book.id, actual.id
        assert_equal book.title, actual.title
      end
    end
  end

  describe "#find_by_title" do
    let(:book){ Book.new(title: "Foundation") }
    before do
      book.save
    end
    describe "if there is a matching book in the database" do
      it "should return the book, populated with id and name" do
        actual = Book.find_by_title("Foundation")
        assert_equal book.id, actual.id
        assert_equal book.title, actual.title
      end
    end
  end


  describe "equality" do
    describe "when the book ids are the same" do
      it "is true" do
        book1 = Book.new(title: "foo")
        book1.save
        book2 = Book.all.first
        assert_equal book1, book2
      end
    end
    describe "when the book ids are not the same" do
      it "is true" do
        book1 = Book.new(title: "foo")
        book1.save
        book2 = Book.new(title: "foo")
        book2.save
        assert book1 != book2
      end
    end
  end

  describe "#count" do
    describe "if there are no books in the database" do
      it "should return 0" do
        assert_equal 0, Book.count
      end
    end
    describe "if there are books" do
      before do
        create_book("Bob")
        create_book("Sally")
        create_book("Amanda")
      end
      it "should return the correct count" do
        assert_equal 3, Book.count
      end
    end
  end

  describe ".initialize" do
    it "sets the title attribute" do
      book = Book.new(title: "foo")
      assert_equal "foo", book.title
    end
  end

  describe ".save" do
  	describe "if the model is valid" do
  		let(:book){ Book.new(title: "Guards, Guards") }
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
  		let(:book){ Book.new(title: "") }
  		it "returns false" do
  			refute book.save
  		end
  		it "does not save the model to the database" do
  			book.save
  			assert_equal 0, Book.count
  		end
  		it "populates the error message" do
  			book.save
  			assert_equal ["Title can't be blank."], book.errors.full_messages
  		end
  	end

    describe "if the title is a duplicate" do
      before do
        create_book("Foundation")
      end
      let(:book){ Book.new(title: "Foundation") }
      it "returns false" do
        refute book.save
      end
      it "does not save the model to the database" do
        book.save
        assert_equal 1, Book.count
      end
      it "populates the error message" do
        book.save
        assert_equal "Title has already been taken. Please add a different book.", book.errors.full_messages.join
      end
    end
  end

  describe ".valid?" do
  	describe "with valid data" do
  		let(:book){ Book.new(title: "Mort") }
  		it "returns true" do
  			assert book.valid?
  		end
  	end
  	describe "with no title provided" do
  		let(:book){ Book.new(title: nil) }
  		it "returns false" do
  			refute book.valid?
  		end
  		it "sets the error message" do
  			book.valid?
  		  assert_equal ["Title can't be blank."], book.errors.full_messages
      end
  	end
  	describe "with empty string title" do
  		let(:book){ Book.new(title: "") }
  		it "returns false" do
  			refute book.valid?
  		end
  		it "sets the error message" do
  			book.valid?
  			assert_equal ["Title can't be blank."], book.errors.full_messages
  		end
  	end
  	describe "with a previously invalid title" do
  		let(:book){ Book.new(title: "") }
  		before do
  			refute book.valid?
  			book.title = "Carpe Jugulum"
  			assert_equal "Carpe Jugulum", book.title
  		end
  		it "should return true" do
  			assert book.valid?
  		end
  	end
  end

  describe "updating book information" do

  	describe "successful edit of previously entered book record" do
  		let(:book_title){ "Carpe Jugulam" }
  		let(:new_book_title){ "Carpe Jugulum" }
  		it "updates book name but not id" do
  			book = Book.new(title: book_title)
  			book.save
  			assert_equal 1, Book.count
  			book.title = new_book_title
  			assert book.save
   			assert_equal 1, Book.count
   			last_row = Database.execute("SELECT * FROM books")[0]
  			assert_equal new_book_title, last_row['title']
  		end

  	  it "only changes the desired record" do
  	  	book2 = Book.new(title: "Equal Rites")
  	  	book2.save
  	  	book = Book.new(title: book_title)
  	  	book.save
  	  	assert_equal 2, Book.count
  	  	book.title = new_book_title
  	  	assert book.save
  	  	assert_equal 2, Book.count

  	  	book3 = Book.find(book2.id)
  	  	assert_equal book2.title, book3.title
  	  end
  	end

  	describe "edit fails when no new title provided" do
  		let(:book_title){ "Carpe Jugulum" }
  		let(:new_book_title){ "" }
  		it "does not update anything" do
  			book = Book.new(title: book_title)
  			book.save
  			assert_equal 1, Book.count
  			book.title = new_book_title
  			refute book.save
  			last_row = Database.execute("SELECT * FROM books")[0]
  			assert_equal book_title, last_row['title']
  		end
  	end
  end

end
