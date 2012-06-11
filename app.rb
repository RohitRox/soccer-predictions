# dev hint: shotgun login.rb

require 'sinatra'

require './config/data.rb'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  enable :sessions
end

helpers do
  def username
    session[:identity] ? session[:identity] : 'Hello stranger'
  end
end

before '/secure/*' do
  if !session[:identity]
    session[:previous_url] = request.env["REQUEST_PATH"]
    @error = 'You need to be logged in to do that'
    halt haml(:login)
  end
end

get '/' do
  @matches = Match.all
  haml :matches
end


get "/sign_up" do
  @user = User.new
  haml :sign_up
end

post "/sign_up" do
  @user = User.create(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])
  
  if @user.save  
    redirect "/"
  else
    haml :sign_up
  end
end


get '/login' do
  haml :login
end

post '/login' do
  p session
  where_user_came_from = session[:previous_url] || '/'
  if User.authenticate(params[:email], params[:password])
    session[:identity] = params['email']
    redirect to where_user_came_from
  else
    @error = "Failed to log in"
    haml(:login)
  end
end

get '/log_out' do
  session.delete(:identity)
  @error = "Logged Out"
  redirect to "/"
end


get '/secure/place' do
  erb "This is a secret place that only <%=session[:identity]%> has access to!"
end


get '/matches' do
  @matches = Match.all
  haml :matches
end
