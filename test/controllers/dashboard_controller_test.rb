require "test_helper"

class DashboardControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @user = User.create!(email: "test@example.com", password: "password123", password_confirmation: "password123")
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
  end
end
