# dev hint: shotgun login.rb

require 'sinatra'

require './config/data.rb'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  enable :sessions
end

before '/secure/*' do
  if !session[:identity]
    session[:previous_url] = request.env["REQUEST_PATH"]
    @error = 'You need to be logged in to do that'
    halt haml(:login)
  end
end

get '/' do
  @matches_by_date = Match.all_grouped_by_kick_off_date
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
  where_user_came_from = session[:previous_url] || '/'
  if User.authenticate(params[:email], params[:password])
    session[:identity] = params['email']
    redirect to where_user_came_from
  else
    @error = "Incorrect Email/Password"
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



helpers do
  def current_user
    session[:identity].nil? ? nil : (@user ||= User.first(email: session[:identity]))
  end
    
  def logged_in?
    !current_user.nil?
  end
  
  def country_flag_image(country_name)
    abbr = case country_name
    when "Netherlands"; "NED"
    when "Republic of Ireland"; "IRL"
    when "Spain"; "ESP"
    else; country_name[0..2].upcase
    end
    "http://img.uefa.com/imgml/flags/50x50/#{abbr}.png"
  end
end