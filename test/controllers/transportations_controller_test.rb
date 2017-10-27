require 'test_helper'

class TransportationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transportation = transportations(:one)
  end

  test "should get index" do
    get transportations_url
    assert_response :success
  end

  test "should get new" do
    get new_transportation_url
    assert_response :success
  end

  test "should create transportation" do
    assert_difference('Transportation.count') do
      post transportations_url, params: { transportation: { transportation: @transportation.transportation } }
    end

    assert_redirected_to transportation_url(Transportation.last)
  end

  test "should show transportation" do
    get transportation_url(@transportation)
    assert_response :success
  end

  test "should get edit" do
    get edit_transportation_url(@transportation)
    assert_response :success
  end

  test "should update transportation" do
    patch transportation_url(@transportation), params: { transportation: { transportation: @transportation.transportation } }
    assert_redirected_to transportation_url(@transportation)
  end

  test "should destroy transportation" do
    assert_difference('Transportation.count', -1) do
      delete transportation_url(@transportation)
    end

    assert_redirected_to transportations_url
  end
end
