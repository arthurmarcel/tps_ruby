# Spécification de Array#join
describe "Array#join" do
	before(:each) do
		@a = ["a", "b", "c"]
	end
	
	it "should return a String" do
		@a.join.should be_a String
	end

	context "when no argument given" do
			it "sould concatenate each element" do
				@a.join.should == "abc"
			end
	end

	context "whith a non empty parameter" do
		it "should interweave the argument between each element" do
			arg = ":"
			@a.join(":").should == "a:b:c"
		end
	end
end
