require "test_helper"

class Users::OpinionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_opinions_index_url
    assert_response :success
  end

  test "should get show" do
    get users_opinions_show_url
    assert_response :success
  end

  test "should get edit" do
    get users_opinions_edit_url
    assert_response :success
  end
end
