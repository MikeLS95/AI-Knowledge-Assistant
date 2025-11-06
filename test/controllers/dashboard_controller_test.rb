require "test_helper"

class DashboardControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user = users(:one)  # or create a user however you normally do
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
  end
end
