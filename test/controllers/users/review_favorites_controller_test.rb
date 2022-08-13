require "test_helper"

class Users::ReviewFavoritesControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get users_review_favorites_create_url
    assert_response :success
  end

  test "should get destroy" do
    get users_review_favorites_destroy_url
    assert_response :success
  end
end
