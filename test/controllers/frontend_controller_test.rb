require 'test_helper'

class FrontendControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get upload" do
    get :upload
    assert_response :success
  end

  test "should get file" do
    get :file
    assert_response :success
  end

end
