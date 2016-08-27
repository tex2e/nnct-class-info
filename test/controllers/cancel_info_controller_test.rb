require 'test_helper'

class CancelInfoControllerTest < ActionDispatch::IntegrationTest
  test "should responce ok" do
    (1..5).each do |grade|
      get "/cancel_info/#{grade}"
      assert_response :success
    end
  end
end
