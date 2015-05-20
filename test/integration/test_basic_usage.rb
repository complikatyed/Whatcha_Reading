require_relative '../test_helper.rb'

class TestBasicUsage < Minitest::Test

  def test_invalid_menu_argument
    shell_output = ""
    expected_output = ""
    IO.popen('./whatcha_reading blah', 'r+') do |pipe|
      expected_output = "[Help] Run as: ./whatcha_reading\n"
      shell_output = pipe.read
    end
      assert_equal expected_output, shell_output
  end
end
