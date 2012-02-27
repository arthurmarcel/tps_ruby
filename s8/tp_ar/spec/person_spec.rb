require_relative 'spec_helper'
require 'person'

describe Person do
	
	it "should have a last_name, first_name and unique username" do
		subject.should_not be_valid
	end
	
end
