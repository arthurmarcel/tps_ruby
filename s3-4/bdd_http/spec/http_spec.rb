# Add http module path
$: << File.dirname(__FILE__)
$:.unshift File.join(File.dirname(__FILE__), '..')

require 'http'

# Request description
describe HTTP::Request do
	context "Request Creation" do
		before (:each) do
			socket = double(Socket)
			socket.stub(:gets).and_return("GET / HTTP1.1", "Host: localhost:8181", "Content-Length: 19", "User-Agent: Mozilla", "Accept: text.html", "\r\n")
			socket.stub(:read).and_return("Corps de la requete")
			@req = HTTP::Request.new(socket)
		end
		
		it "should initialize the socket attribute" do
			@req.valid.should be_true
		end
	
		it "should read the status" do
			@req.status.should == "GET / HTTP1.1"
		end
		
		it "should read the headers" do
			@req.headers["User-Agent"].should == "Mozilla"
			@req.headers.length.should == 4
		end
		
		it "should read the body" do
			@req.body.should == "Corps de la requete"
		end
	end
	
	context "Request Creation without body" do
		it "should not read the body" do
			socket = double(Socket)
			socket.stub(:gets).and_return("GET / HTTP1.1", "Host: localhost:8181", "User-Agent: Mozilla", "Accept: text.html", "\r\n")
			req = HTTP::Request.new(socket)
			req.body.should be_nil
		end
	end
end

describe HTTP::Response do
	context "Response creation" do
		it "should build a response" do
			res = HTTP::Response.new
			res.code = "200"
			res.http_version = "HTTP/1.1"
			res.code_message = "ok"
			res.headers["Content-Length"] = "19"
			res.headers["Content-Type"] = "text/plain"
			res.body = "Corps de la reponse"
			res.to_s.should == "200 HTTP/1.1 ok\n{\"Content-Length\"=>\"19\", \"Content-Type\"=>\"text/plain\"}\n\r\nCorps de la reponse"		
		end
	end
end
