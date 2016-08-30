require 'test_helper'

# # refinement
# module CancelInfoControllerExtender
#   refine CancelInfoController do
#     def get_url(hash = {})
#       grade = hash[:grade].to_s
#       grade_map = {"1" => "1st", "2" => "2nd", "3" => "3rd", "4" => "4th", "5" => "5th"}
#       grade_str = grade_map[grade]
#       "http://localhost:3000/cancel_info_test_data/cancel_info_#{grade_str}.html"
#     end
#   end
# end


# IntegrationTest
class CancelInfoApiTest < ActionDispatch::IntegrationTest
  # using CancelInfoControllerExtender

  test "should get all canceled info of specified grade" do
    grade = 3
    get "/cancel_info/#{grade}"
    response_json = JSON.parse(response.body)

    assert response_json.first.has_key?("grade")
    assert response_json.first.has_key?("type_str")
    assert response_json.first.has_key?("date_str")
    assert response_json.first.has_key?("date")
    assert response_json.first.has_key?("altdate_str")
    assert response_json.first.has_key?("altdate")
    assert response_json.first.has_key?("classroom")
    assert response_json.first.has_key?("department")
    assert response_json.first.has_key?("teacher")
    assert response_json.first.has_key?("note")
  end

  test "should get all tomorrow info" do
    grade = 5
    get "/cancel_info/#{grade}/only_tomorrow", params: { test: true }
    response_json = JSON.parse(response.body)
    assert_equal 1, response_json.length
  end
end
