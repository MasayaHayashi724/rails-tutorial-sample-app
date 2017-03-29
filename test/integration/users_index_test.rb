require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:tester)
    @non_admin = users(:archer)
    @non_activated = users(:lana)
  end

  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination', count: 2
    first_page_of_users = User.where(activated: true).paginate(page: 1)
    first_page_of_users.each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "index as non-admin" do
    log_in_as(@non_admin)
    get users_path
    assert_select 'a', text: 'delete', count: 0
  end

  test "index should not include non-activated users" do
    log_in_as(@admin)
    assert @admin.activated?
    get users_path
    assert_template 'users/index'
    num_page = (User.count / 30.0).ceil
    for i in 1..num_page do
      users = User.where(activated: true).paginate(page: i)
      users.each do |user|
        assert user.activated?
      end
    end
  end

  test "activated users should be able to see profile page" do
    log_in_as(@admin)
    assert @admin.activated?
    get user_path(@admin)
    assert_template "users/show"
  end

  test "non-activated users should not be able to see profile page" do
    log_in_as(@non_activated)
    assert_not @non_activated.activated?
    get user_path(@non_activated)
    assert_redirected_to root_url
    follow_redirect!
    assert_template 'static_pages/home'
  end

end
