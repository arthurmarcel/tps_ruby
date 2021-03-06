class AuthApi

	attr_reader :user_model
	attr_reader :find_method
	attr_reader :decodedLogPass
	attr_reader :result
	
  def initialize(app, options = {})
    @app = app
    @user_model = options[:user_model]
    @find_method = options[:find_method]
  end
  
  def self.decode_http_authorize(base64)
  	base64.unpack('m')[0].split(':')
  end

  def call(env)
		#  	req = Rack::Request.new(env)
	  base64 = env.delete('HTTP_AUTHORIZATION') if env['HTTP_AUTHORIZATION']
	  base64.gsub!(/Basic /, "") if base64
  	@decodedLogPass = AuthApi.decode_http_authorize(base64) if base64
  	@result = @user_model.@find_method(@decodedLogPass[0]) if @decodedLogPass[0]
    status, headers, body = @app.call(env)
  end
end
