require "test_helper"

class Admins::ReviewCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admins_review_comments_destroy_url
    assert_response :success
  end
end
