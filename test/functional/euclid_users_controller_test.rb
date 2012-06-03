require 'test_helper'

class EuclidUsersControllerTest < ActionController::TestCase
  setup do
    @euclid_user = euclid_users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:euclid_users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create euclid_user" do
    assert_difference('EuclidUser.count') do
      post :create, euclid_user: @euclid_user.attributes
    end

    assert_redirected_to euclid_user_path(assigns(:euclid_user))
  end

  test "should show euclid_user" do
    get :show, id: @euclid_user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @euclid_user
    assert_response :success
  end

  test "should update euclid_user" do
    put :update, id: @euclid_user, euclid_user: @euclid_user.attributes
    assert_redirected_to euclid_user_path(assigns(:euclid_user))
  end

  test "should destroy euclid_user" do
    assert_difference('EuclidUser.count', -1) do
      delete :destroy, id: @euclid_user
    end

    assert_redirected_to euclid_users_path
  end
end
