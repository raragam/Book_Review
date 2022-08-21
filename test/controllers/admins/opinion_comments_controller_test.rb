require "test_helper"

class Admins::OpinionCommentsControllerTest < ActionDispatch::IntegrationTest
  test "should get destroy" do
    get admins_opinion_comments_destroy_url
    assert_response :success
  end
end
