require 'test_helper'

class ProfileControllerTest < ActionController::TestCase
  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get edit" do
    get :edit
    assert_response :success
  end

  test "should get password" do
    get :password
    assert_response :success
  end

end
