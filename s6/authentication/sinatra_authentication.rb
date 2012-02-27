require 'sinatra'
$: << File.join(File.dirname(__FILE__),"","middleware")
require 'my_middleware'

use RackCookieSession
use RackSession

helpers do 
  def current_user
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

post '/sessions' do
	# Je regarde si l'utilisateur existe
	if params["login"] == "toto" and params["password"] == "titi"
		#Redirection vers protected et ajout du current_user
		session["current_user"] = params["login"]
		redirect '/protected'
	else
		# Erreur, je redirige vers le formulaire
		redirect '/sessions/new'
	end
end

get '/protected' do
	# Test sur le current_user
	if not current_user.nil?
		# Défini, on affiche un message
		# Soit, @user = current_user, soit :
		erb :protected, :locals => {:user=>current_user}
	else
		# Non défini, on redirige vers /sessions/new
		redirect '/sessions/new'
	end
end

get '/sessions/quit' do
	disconnect
	redirect '/sessions/new'
end
