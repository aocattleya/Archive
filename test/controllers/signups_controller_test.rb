require 'test_helper'

class SignupsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signups_new_url
    assert_response :success
  end

end
