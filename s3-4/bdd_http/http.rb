require 'socket'

class HTTP

 class Request
	
	attr_reader :status
	attr_reader :headers
	attr_reader :body
  attr_reader :path
	
	def initialize(socket)
		@socket = socket
		lireStatus
		lireHeaders
		lireBody if @body_length
	end
	
	def valid
		not @socket.nil?
	end
	
	def lireStatus
		@status = @socket.gets
		@path = @status.split(" ")[1]
	end
	
	def lireHeaders
		@headers = {}
		while not (line = @socket.gets).strip.empty? do
			splitLine = line.split(": ")
			@headers[splitLine[0]] = splitLine[1]
			@body_length = splitLine[1] if splitLine[0] == "Content-Length"
		end
	end
	
	def lireBody
		@body = @socket.read(@body_length.to_i)
	end
	
 end
 
 class Response
 	attr_accessor :code
  attr_accessor :http_version
  attr_accessor :code_message
  attr_accessor :headers
  attr_accessor :body
  
  def initialize
   @headers = {}
  end
  
  def write(s)
  	@body << s
  end
  
  def to_s
    status = [@code, @http_version, @code_message].join(' ')
    header = @headers.to_s
    blank = "\r"
    [status, header, blank, @body].join("\n")
  end
 end
 
end
