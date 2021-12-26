require "test_helper"

class FollowshipsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get followships_index_url
    assert_response :success
  end

  test "should get follow" do
    get followships_follow_url
    assert_response :success
  end

  test "should get unfollow" do
    get followships_unfollow_url
    assert_response :success
  end
end
