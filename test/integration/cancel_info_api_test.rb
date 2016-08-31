require 'test_helper'

# # refinement
# module CancelInfoControllerExtender
#   refine CancelInfoController do
#     @@url = -> grade { "../../public/cancel_info_test_data/cancel_info_#{grade}.html" }
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

    default_url = CancelInfoController.class_variable_get(:@@url)
    CancelInfoController.class_variable_set(:@@url, -> grade { "public/cancel_info_test_data/cancel_info_#{grade}.html" })

    # On 2016/8/30, get all info on 2016/8/31
    Timecop.freeze(Time.local(2016, 8, 30)) do
      get "/cancel_info/#{grade}/only_tomorrow"
      response_json = JSON.parse(response.body)
      assert_equal 1, response_json.length
    end

    CancelInfoController.class_variable_set(:@@url, default_url)
  end
end
