require_relative '../test_helper'

class TestListingBooks < Minitest::Test

  def test_no_scenarios_to_list
    shell_output = ""
    expected_output = ""
    IO.popen('./whatcha_reading list', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "No books found. Please add a new book.\n"
      expected_output << main_menu
      pipe.puts "Exit"
      expected_output << "Go read something!\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end

  def test_listing_multiple_books
    create_book("Sorcery")
    create_book("Equal Rites")
    create_book("Witches Abroad")
    shell_output = ""
    expected_output = ""
    IO.popen('./whatcha_reading', 'r+') do |pipe|
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "Title:  Sorcery\n"
      expected_output << "Topic:  \n"
      expected_output << "Rank:    stars\n"
      expected_output << "Start:  \n"
      expected_output << "Finish: \n"
      expected_output << "\n"
      expected_output << "Title:  Equal Rites\n"
      expected_output << "Topic:  \n"
      expected_output << "Rank:    stars\n"
      expected_output << "Start:  \n"
      expected_output << "Finish: \n"
      expected_output << "\n"
      expected_output << "Title:  Witches Abroad\n"
      expected_output << "Topic:  \n"
      expected_output << "Rank:    stars\n"
      expected_output << "Start:  \n"
      expected_output << "Finish: \n"
      expected_output << "\n"
      expected_output << exit_from(pipe)
      pipe.close_write
      shell_output = pipe.read
    end
    assert_equal expected_output, shell_output
  end
end