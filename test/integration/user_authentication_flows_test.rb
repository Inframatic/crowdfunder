require 'test_helper'

	class UserAuthenticationFlowsTest < ActionDispatch::IntegrationTest
	  test "successful registration" do
	  	visit "/users/new"
	  	assert_equal new_user_path, current_path

	  	assert find('.navbar').has_link?('Sign up')

	  	user = FactoryGirl.build(:user)
	  	fill_in "user[email]", :with => user.email
		fill_in "user[first_name]", :with => user.first_name
		fill_in "user[last_name]", :with => user.last_name
		fill_in "user[password]", :with => user.password
		click_button "Create Account"

		assert_equal root_path, current_path

		assert page.has_content?("Account created")

		assert find('.navbar').has_no_link?('Sign Up')
		assert_find('.navbar').has_link?('Logout')
	end

	test "failed registration" do
	user = FactoryGirl.build(:user)

	fill_in "user[email]", :with => user.email
	click_button "Create Account"

	assert_equal users_path, current_path
	assert_equal users_path, current_path
	assert page.has_no_content?("Account created")
	end

  # test "the truth" do
  #   assert true
  # end
end
