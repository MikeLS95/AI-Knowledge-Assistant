require "test_helper"

class DashboardControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should redirect to sign in when not authenticated" do
    get :index
    assert_redirected_to new_user_session_path
  end
end
