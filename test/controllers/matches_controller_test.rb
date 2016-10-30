require 'test_helper'

class MatchesControllerTest < ActionDispatch::IntegrationTest
  test "should get make_match" do
    get matches_make_match_url
    assert_response :success
  end

  test "should get match_found" do
    get matches_match_found_url
    assert_response :success
  end

  test "should get match_not_found" do
    get matches_match_not_found_url
    assert_response :success
  end

end
