#Fichier de test de la classe classy_http_debug_server
$: << File.dirname(__FILE__)

require 'http'


describe HTTP::Request do
	context "creation of the Request Object" do
		it "should read the request" do
			socket = double (Socket)
			socket.stub(:gets).and_return("GET / HTTP1.1", "Host: localhost:8080", "Content-Length: 26", "User-Agent: Mozilla", "Accept: text.html", "\r\n")
			socket.stub(:read).and_return("Ici le corps de ma requete")
			req = HTTP::Request.new(socket)
			req.status.should == "GET / HTTP1.1"

			req.headers["User-Agent"].should == "Mozilla"
			req.headers.length.should == 4
			
			req.body.should == "Ici le corps de ma requete"
		end
	end
end

describe HTTP::Response do
	context "creation of the Response Object" do
		it "should write the string of a response" do
			res = HTTP::Response.new
			res.code = "200"
			res.http_version = "HTTP/1.1"
			res.code_message = "ok"
			res.headers["Content-Length"] = "26"
			res.headers["Content-Type"] = "text/plain"
			res.body = "Ici le corps de ma reponse"
			res.to_s.should == "200 HTTP/1.1 ok\n{\"Content-Length\"=>\"26\", \"Content-Type\"=>\"text/plain\"}\n\r\nIci le corps de ma reponse"		
		end
	end
end
