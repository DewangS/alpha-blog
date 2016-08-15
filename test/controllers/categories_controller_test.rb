require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  
  def setup
    @category = Category.create(name: "sports")
    @user = User.create(username: "Dev", email: "dshahu@yahoo.com", password: "password", admin: true)
  end

  test "should get categories index" do
    get :index
    assert_response :success
  end
  
  test "should get new" do
    session[:user_id] = @user.id
    post :new
    assert_response :success
  end

  test "should get show" do
    get(:show, {id: @category.id})
    assert_response :success
  end

  test "should edit category" do
    session[:user_id] = @user.id
    get(:edit, {id: @category.id})
    assert_response :success
  end

  test "should redirect create when admin not logged in" do
      assert_no_difference 'Category.count' do
        post(:create, category: {name: "Sports"})
      end
      assert_redirected_to categories_path
  end
end