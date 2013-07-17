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
	assert find('.alert:first').has_content?("Try again")
	end

  # test "the truth" do
  #   assert true
  # end

  test "successful log in" do
    visit '/'
    assert find('.navbar').has_no_link?('Logout')
    # Calling the helper method here, and it returns a user
    user = setup_signed_in_user
    assert find('.navbar').has_link?('Logout')
  end

  test "unsuccessful log in" do
    visit '/session/new'

    fill_in "email", with: "a@b.com"
    fill_in "password", with: "invalid creds"
    click_button "Login"

    assert_equal session_path, current_path

    assert page.has_content?('Invalid')
  end

  test "successful logout" do
    # javascript_driver can handle JS which we need for logout button, 
    # since the button uses `method: delete` Rails UJS helper    
    Capybara.current_driver = Capybara.javascript_driver

    # Calling the helper method again
    user = setup_signed_in_user

    visit '/'

    find('.navbar').click_link 'Logout'

    assert page.has_content?("Bye")
    assert find('.navbar').has_no_link?('Logout')
   end
end
