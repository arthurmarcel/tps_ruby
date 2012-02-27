class RackSession
  attr_reader :pool

  def initialize(app)
    @app = app
    @pool = Hash.new
  end

  def call(env)
    load_session(env)
    status, headers, body = @app.call(env)
    commit_session(env)
    [status, headers, body]
  end

  def load_session(env)
    env['rack.session'] = @pool[env['rack.session.id']]
  end

  def commit_session(env)
    @pool[env['rack.session.id']] = env['rack.session']
  end
end
