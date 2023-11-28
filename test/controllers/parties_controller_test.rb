require "test_helper"

class PartiesControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get parties_new_url
    assert_response :success
  end
end
