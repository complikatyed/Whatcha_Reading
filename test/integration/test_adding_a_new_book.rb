require_relative '../test_helper'

class AddingANewBookTest < Minitest::Test

	def test_happy_path_adding_a_book
		shell_output = ""
		expected_output = ""
		test_book = "Moving Pictures"
		IO.popen('./whatcha_reading add', 'r+') do |pipe|
			expected_output << "What book would you like to add?\n"
			pipe.puts test_book
			expected_output << "\"#{test_book}\" has been added.\n"
			shell_output = pipe.read
			pipe.close_write
			pipe.close_read
		end
		assert_equal expected_output, shell_output
	end

  def test_sad_path_adding_a_book
    shell_output = ""
    happy_scenario = "Moving Pictures"
    expected_output = ""
    IO.popen('./whatcha_reading add', 'r+') do |pipe|
      expected_output << "What book would you like to add?\n"
      pipe.puts "  "
      expected_output << "\'\' is not a valid book title.\n"
      expected_output << "What book would you like to add?\n"
      pipe.puts happy_scenario
      expected_output << "\"#{happy_scenario}\" has been added.\n"
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
    assert_equal expected_output, shell_output
  end
end