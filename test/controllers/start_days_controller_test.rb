require 'test_helper'

class StartDaysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get start_days_index_url
    assert_response :success
  end

end
