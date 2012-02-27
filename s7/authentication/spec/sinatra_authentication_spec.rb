require 'spec_helper'

def app
  Sinatra::Application
end

describe "accessing the protected area" do
  describe "without basic authentication and session" do
    it "should redirect to login form" do 
      get '/protected'
      follow_redirect!
      last_request.path.should == '/sessions/new'
    end
  end
    
  describe "with basic http authentication Bob:12345" do 
    it "should have the identity in rack.auth.api" do 
      basic_authorize "Bob", "12345"
      get '/protected'
      last_request.env['rack.auth.api'].should == { :uid => "Bob" }
    end

    it "should access the protected area" do 
      basic_authorize "Bob", "12345"
      get '/protected'
      last_response.should be_ok
    end
  end
end
