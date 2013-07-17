require 'test_helper'

class ProjectFlowsTest < ActionDispatch::IntegrationTest
  test "browsing projects" do
  	laser_gun = FactoryGirl.create(:project, :title => "Laser Gun")
  	stun_ray = FactoryGirl.create(:project, :title => "Stun Ray")
  	death_ray = FactoryGirl.create(:project, :title => "Death Ray")

  	#go to page with products
  	visit "/projects"
  	#Assert that the page we're on is the page for the projects
  	assert_equal projects_path, current_path

  	#Assert this page has the words 'Listing Projects'
  	assert page.has_content?('Listing projects')

  	#Assert this page has these words as well
  	assert page.has_content?('Laser Gun')
  	assert page.has_content?('Stun Ray')
  	assert page.has_content?('Death Ray')
  # test "the truth" do
  #   assert true
  # end
  end
  test "navigation" do

  	#visit url root
  	visit "/"
  	assert_equal root_path, current_path
  	#Assert the projects nav element is active
  	assert_equal "Home", find('.navbar ul li.active a').text

  	#Click on the link to Projects
  	find('.navbar ul').click_link('Projects')
  	#Assert the page we're on is the projects page
  	assert_equal projects_path, current_path
  	assert_equal "Projects", find('.navbar ul li.active a').text
  end 
end
