class RackCookieSession

  def initialize(app,env_session_id_key="rack.session.id",cookie_name="session_id")
    @app = app
    @env_session_id_key = env_session_id_key
    @cookie_name = cookie_name
  end

  def call(env)  	
    # new session or not
    sess_id = extract_session_id(env)
    
    # if new : generate session_id
    if sess_id
    	new_session = false
    else
      # if not : extract_session_id
    	new_session = true
    	sess_id = generate_session_id
    end
    
    # store session id into env with the key env_session_id_key
    env[@env_session_id_key] = sess_id
    
    status, headers, body = @app.call(env)
    res = Rack::Response.new(body, status, headers)
    res.set_cookie(@cookie_name, sess_id) if new_session
    
    # set cookie in headers if necessary
    [res.status, res.headers, res.body]
  end

  def extract_session_id(env)
    # get session id from cookie named @cookie_name
    req = Rack::Request.new(env)
    req.cookies[@cookie_name]
  end

  def generate_session_id(bit_size=32)
    rand(2**bit_size - 1)
  end

end
    

