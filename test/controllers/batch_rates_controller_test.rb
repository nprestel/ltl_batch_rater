require 'test_helper'

class BatchRatesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get batch_rates_index_url
    assert_response :success
  end

  test "should get import" do
    get batch_rates_import_url
    assert_response :success
  end

end
