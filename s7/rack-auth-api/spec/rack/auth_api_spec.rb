require 'spec_helper'

describe AuthApi do 

	class User
	
	end
 
  def app 
    auth_options = {:user_model => User, :find_method => :find}
    app = Rack::Builder.app do
      use AuthApi, auth_options
      run lambda{|env| [404, {'env' => env}, ["HELLO!"]]}
    end
  end

  subject { AuthApi.new(lambda{|env| [404, {'env' => env}, ["HELLO!"]]}, 
                        {:user_model => User, :find_method => :find})}
                        
  # Spécification d'initialisation
  it "should set the find_method with the given option" do
  	subject.find_method.should == :find
  end
  
  it "should set the user_model with the given option" do
  	subject.user_model.should == User
  end
             
  # Cas 1 : pas de header HTTP_AUTHORIZE
  context "when no HTTP_AUTHORIZE header" do
		it "should do nothing" do
			get '/'
			last_response.status.should === 404
		end
	end
	
	context "decode_http_authorize" do
		it "should decode password and login" do
			AuthApi.decode_http_authorize("dG90bzoxMjM0\n").should == ['toto', '1234']
		end
	end
	
	# Cas 2 : HTTP_AUTHORIZE présent
  context "when HTTP_AUTHORIZATION header is found" do
		before(:all) do
	 		basic_authorize "toto", "1234"
		end
		
		it "should decode the login and the password" do
			AuthApi.should_receive(:decode_http_authorize).with(["toto:1234"].pack('m'))
			get '/'	
		end
		
		it "should erase HTTP_AUTHORIZATION" do
			get '/'
			last_request.env['HTTP_AUTHORIZATION'].should be_nil
		end
		
		it "should check if toto:1234 is known to User.find" do
			
		end
		
		it "should modify env if valid user" do
			
		end
	end                    

end
