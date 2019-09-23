require 'test_helper'

class StudysControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get studys_index_url
    assert_response :success
  end

  test "should get show" do
    get studys_show_url
    assert_response :success
  end

  test "should get new" do
    get studys_new_url
    assert_response :success
  end

  test "should get edit" do
    get studys_edit_url
    assert_response :success
  end

end
