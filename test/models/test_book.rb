require_relative '../test_helper'

  describe ".initialize" do
    it "sets the title attribute" do
      book = Book.new("foo")
      assert_equal "foo", book.title
    end
  end