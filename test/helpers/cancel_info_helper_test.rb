require 'test_helper'

class CancelInfoHelperTest < ActionDispatch::IntegrationTest
  using CancelInfoHelper

  test "yesterday" do
    assert Time.zone.now.yesterday.yesterday?
  end

  test "tomorrow" do
    assert Time.zone.now.tomorrow.tomorrow?
  end
end
