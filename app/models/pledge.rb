class Pledge < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
	  FactoryGirl.define do
	  factory :pledge do
	    amount 100
	    user
	    project
	  end
	end
end
