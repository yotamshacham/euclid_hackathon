require 'test_helper'

class EuclidUserMessagesControllerTest < ActionController::TestCase
  setup do
    @euclid_user_message = euclid_user_messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:euclid_user_messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create euclid_user_message" do
    assert_difference('EuclidUserMessage.count') do
      post :create, euclid_user_message: @euclid_user_message.attributes
    end

    assert_redirected_to euclid_user_message_path(assigns(:euclid_user_message))
  end

  test "should show euclid_user_message" do
    get :show, id: @euclid_user_message
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @euclid_user_message
    assert_response :success
  end

  test "should update euclid_user_message" do
    put :update, id: @euclid_user_message, euclid_user_message: @euclid_user_message.attributes
    assert_redirected_to euclid_user_message_path(assigns(:euclid_user_message))
  end

  test "should destroy euclid_user_message" do
    assert_difference('EuclidUserMessage.count', -1) do
      delete :destroy, id: @euclid_user_message
    end

    assert_redirected_to euclid_user_messages_path
  end
end
