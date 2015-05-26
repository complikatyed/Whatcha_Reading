require_relative "../test_helper"

describe BooksController do

  describe ".index" do
    let(:controller) {BooksController.new}
    it "should say no books found when empty" do
      skip
      actual_output = controller.index
      expected_output = "No books found. Please add a new book.\n"
      assert_equal expected_output, actual_output
    end
  end

  describe ".add" do
    let(:controller) {BooksController.new}
    title = "Equal Rites"
    start = "2014/04/12"
    it "should add a book" do
      controller.add(title, start)
      assert_equal 1, Book.count
    end
    it "should not add book all spaces" do
      title = " "
      start = "2014/04/12"
      result = controller.add(title, start)
      assert_equal "Title can't be blank.", result
    end

  end

end
