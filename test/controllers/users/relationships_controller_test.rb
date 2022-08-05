require "test_helper"

class Users::RelationshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get followings" do
    get users_relationships_followings_url
    assert_response :success
  end

  test "should get followers" do
    get users_relationships_followers_url
    assert_response :success
  end
end
