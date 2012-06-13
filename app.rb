# dev hint: shotgun login.rb

require 'sinatra'
require 'json'

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

before "/match/*/result" do
  unless admin?
    halt 404
  end
end

get '/' do
  @matches_by_date = Match.all_grouped_by_kick_off_date(limit=4)
  haml :matches
end


get '/schedule' do
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
    session.delete(:previous_url)
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
  return_hash = {}
  match = Match.get(params[:id])
  # if there is more than 10 minutes remaining for the match to kick off then only is the user allowed to predict
  if match.competitors_not_decided?
    return_hash[:error] = "The teams for this match haven't been decided yet"
  elsif match.prediction_deadline_passed?
    return_hash[:error] = "The deadline for prediction has passed for this match."
  else
    prediction = current_user.predictions.first_or_create(match_id: match.id)
    prediction.result = params[:prediction]
    if prediction.save
      return_hash[:result] = prediction.message
    else
     return_hash[:error] = "You can't do that. Trying something naughty huh?"
    end
  end
  content_type :json
  return_hash.to_json
end

get "/match/:id/result" do
  @match = Match.get(params[:id])
  haml :result
end

post "/match/:id/result" do
  @match = Match.get(params[:id])
  team_a_score = params[:team_a].to_i
  team_b_score = params[:team_b].to_i
  if team_a_score > team_b_score
    @match.result = @match.team_a
  elsif team_b_score > team_a_score
    @match.result = @match.team_b
  else
    @match.result = "Draw"
  end
  @match.score = "#{team_a_score} - #{team_b_score}"
  if @match.save
    @match.predictions.all(:result.not => @match.result).update(correct: false)
    @match.predictions.all(result: @match.result).update(correct: true)
  else
    @error = "Score could not be updated"
  end
  haml :result
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

  def admin?
    logged_in? && current_user.admin?
  end
end