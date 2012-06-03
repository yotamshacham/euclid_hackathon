require 'test_helper'

class EuclidMessagesControllerTest < ActionController::TestCase
  setup do
    @euclid_message = euclid_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:euclid_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create euclid_message" do
    assert_difference('EuclidMessage.count') do
      post :create, euclid_message: @euclid_message.attributes
    end

    assert_redirected_to euclid_message_path(assigns(:euclid_message))
  end

  test "should show euclid_message" do
    get :show, id: @euclid_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @euclid_message
    assert_response :success
  end

  test "should update euclid_message" do
    put :update, id: @euclid_message, euclid_message: @euclid_message.attributes
    assert_redirected_to euclid_message_path(assigns(:euclid_message))
  end

  test "should destroy euclid_message" do
    assert_difference('EuclidMessage.count', -1) do
      delete :destroy, id: @euclid_message
    end

    assert_redirected_to euclid_messages_path
  end
end
