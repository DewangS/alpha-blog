require 'test_helper'

class UsersControllerTest < ActionController::TestCase

def setup
  @user = User.create(username: "SAm123", email: "ds@example.com", password: "password", admin: true)
end

test "should get user index" do
get :index
assert_response :success
end

test "should get new" do
get :new
assert_response :success
end

test "should get show" do
  assert_response :success
end

end