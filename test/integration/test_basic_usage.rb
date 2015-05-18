require_relative '../test_helper.rb'

class TestBasicUsage < Minitest::Test

	def test_no_menu_argument
    shell_output = ""
    expected_output = ""
    error_message = "[Help] Run as: ./whatcha_reading add edit or list\n"
    IO.popen('./whatcha_reading', 'r+') do |pipe|
      expected_output = error_message
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
      assert_equal expected_output, shell_output
  end

  def test_invalid_menu_argument
    shell_output = ""
    expected_output = ""
    error_message = "[Help] Run as: ./whatcha_reading add edit or list\n"
    IO.popen('./whatcha_reading blah', 'r+') do |pipe|
      expected_output = error_message
      shell_output = pipe.read
      pipe.close_write
      pipe.close_read
    end
      assert_equal expected_output, shell_output
  end
end
