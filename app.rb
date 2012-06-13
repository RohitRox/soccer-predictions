# dev hint: shotgun login.rb

require 'sinatra'

require './config/data.rb'

configure do
  set :public_folder, Proc.new { File.join(root, "static") }
  enable :sessions
end

before '/match/*/predict' do
  unless logged_in?
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


post "/match/:id/predict" do
  match = Match.get(params[:id])
  # if there is more than 10 minutes remaining for the match to kick off then only is the user allowed to predict
  if [match.team_a, match.team_b].include?("TBD")
    @error = "The teams for this match haven't been decided yet"
  elsif match.prediction_deadline_passed?
    @error = "You are not allowed to predict this close to kick off"
  else
    prediction = current_user.predictions.first_or_create(match_id: match.id)
    prediction.result = params[:prediction]
    if prediction.save
      # do something useful
    else
      @error = "You can't do that. Trying something naughty huh?"
    end
  end
  haml :matches
end



helpers do
  def current_user
    session[:identity].nil? ? nil : (@user ||= User.first(email: session[:identity]))
  end
    
  def logged_in?
    !current_user.nil?
  end
  
  def country_flag_image(country_name)
    "images/#{country_name[0..2].upcase}.png"
  end
end