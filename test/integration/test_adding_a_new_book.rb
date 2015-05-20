require_relative '../test_helper'

class AddingANewBookTest < Minitest::Test

	def test_happy_path_adding_a_book
		shell_output = ""
		expected_output = main_menu
		test_book = "Moving Pictures"
		IO.popen('./whatcha_reading', 'r+') do |pipe|
			pipe.puts "1"
      expected_output << "What book would you like to add?\n"
			pipe.puts test_book
			expected_output << "\"#{test_book}\" has been added.\n"
			expected_output << main_menu
      pipe.puts "3"
      expected_output << "1. #{test_book}\n"
      expected_output << "2. Exit\n"
      expected_output << exit_from(pipe)
      shell_output = pipe.read
			pipe.close_write
			pipe.close_read
		end
		assert_equal expected_output, shell_output
	end

  def test_sad_path_adding_a_book
    shell_output = ""
    happy_book = "Moving Pictures"
    expected_output = main_menu
    IO.popen('./whatcha_reading', 'r+') do |pipe|
      expected_output << "What book would you like to add?\n"
      pipe.puts ""
      expected_output << "\'\' is not a valid book title.\n"
      expected_output << "What book would you like to add?\n"
      pipe.puts happy_book
      expected_output << "\"#{happy_book}\" has been added.\n"
      expected_output << main_menu
      pipe.puts "3"
      expected_output << "1. #{happy_book}\n"
      expected_output << "2. Exit\n"
      expected_output << exit_from(pipe)
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end
end