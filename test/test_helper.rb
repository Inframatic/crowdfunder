ENV["RAILS_ENV"] = "test" #Add || before = if this fails
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntergrationTest
	include Capybara::DSL
	Capybara.app= Crowdfunder::Application
	Capybara.javascript_driver = :webkit

	self.use_transactional_fixtures = false

	teardown do
		DatabaseCleaner.clean
		Capybara.reset_sessions!
		Capybara.use_default_driver
	end

	def setup_signed_in_user
		pass = "this-is-a-password"
		user = FactoryGirl.create :user, password: pass
		visit '/sessions/new'

		fill_in "email", with: user.email
		fill_in "password", with: pass
		click_button "Login"
	end
end