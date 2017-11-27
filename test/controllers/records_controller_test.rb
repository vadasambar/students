require 'test_helper'

class RecordsControllerTest < ActionDispatch::IntegrationTest
  test "should get index," do
    get records_index,_url
    assert_response :success
  end

  test "should get create," do
    get records_create,_url
    assert_response :success
  end

  test "should get update," do
    get records_update,_url
    assert_response :success
  end

  test "should get destroy" do
    get records_destroy_url
    assert_response :success
  end

end
