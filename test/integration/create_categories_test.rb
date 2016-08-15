require 'test_helper'

class CreateCategoriesTest < ActionDispatch::IntegrationTest

  def setup
    @category_name = "Sports"
    @user = User.create(username: "Dev", email: "dshahu@yahoo.com", password: "password", admin: true)
  end

  test "get new category form and create category" do
    get new_category_path
    session[:user_id] = @user.id
    assert_template "categories/new"
    assert_difference 'Category.count', 1 do
      post_via_redirect categories_path, category: {name: @category_name}
    end
    assert_template 'categories/index'
    assert_match @category_name, response.body
  end

  test "Invalid category submission results in failure" do
    get new_category_path
    session[:user_id] = @user.id
    assert_template "categories/new"
    assert_no_difference 'Category.count' do
      assert post_via_redirect categories_path, category: {name: " "}
    end
    assert_template 'categories/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end