require 'test_helper'

class VisitorsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get visitors_index_url
    assert_response :success
  end

  test "should get import" do
    get visitors_import_url
    assert_response :success
  end

end
