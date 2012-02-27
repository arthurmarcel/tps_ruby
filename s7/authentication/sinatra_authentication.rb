require 'sinatra'
$: << File.join(File.dirname(__FILE__),"middleware")
require 'my_middleware'
require 'rack-auth-api/lib/rack/auth_api'

class User
  def self.find(key)
    if key == '12345'
      { :uid => "Bob" }
    else
      nil
    end
  end
end

use AuthApi, { :user_model => User, :find_method => :find }
use RackCookieSession
use RackSession


helpers do 
  def current_user
    if env['rack.auth.api']
      session["current_user"] = env['rack.auth.api'][:uid]
    end
    session["current_user"]
  end

  def disconnect
    session["current_user"] = nil
  end
end

get '/' do
  if current_user
    "Bonjour #{current_user}"
  else
    '<a href="/sessions/new">Login</a>'
  end
end

get '/sessions/new' do
  erb :"sessions/new"
end

get '/sessions/destroy' do
  disconnect
  redirect '/'
end

post '/sessions' do
  if params[:login] == "toto"
    session["current_user"] = params[:login]
    redirect "/protected"
  else
    redirect "/sessions/new"
  end
end

before '/protected' do
  redirect 'sessions/new' unless current_user
end

get '/protected' do
  "well played #{current_user}. Now you can <a href=\"/sessions/destroy\">disconnect</a>."
end
