# Homepage (Root path)

configure do
  enable :sessions
end

get '/' do
  erb :index
end

get '/login' do
  erb :login
end

get '/logout' do
  session.clear
  redirect '/login'
end

post '/login' do
  # binding.pry
  @user = User.find_by(user_name: params[:user_name])
  unless @user
    erb :login 
  end
  if params[:user_name] == @user.user_name && params[:password] == @user.password 
    session[:loggedin] = true
    session[:user_name] = params[:user_name]
    session[:user_id] = @user.id
    redirect to('/tracks')
  else
    erb :login
  end 
end

get '/tracks' do
  @tracks = Track.all
  erb :'tracks/index'
end

get '/tracks/new' do
  @track = Track.new
  erb :'tracks/new'
end

post '/tracks' do
  @track = Track.new(
    song_title:   params[:song_title],
    author: params[:author],
    url:  params[:url],
    user_id: settings[:user_id]
  )
  if @track.save
    redirect '/tracks'
  else
    erb :'tracks/new'
  end
end

get '/tracks/show/:id' do
  @track = Track.find params[:id]
  erb :'tracks/show'
end

get '/tracks/upvote/:id' do
  @track = Track.find params[:id]
  erb :'tracks/upvote'
end

get '/users' do
  @users = User.all
  erb :'users/index'
end

get '/users/new' do
  @user = User.new
  erb :'users/new'
end

post '/users' do
  @user = User.new(
    user_name:   params[:user_name],
    password: params[:password],
    email:  params[:email]
  )
  if @user.save
    redirect '/users'
  else
    erb :'users/new'
  end
end

get '/users/show/:id' do
  @user = User.find params[:id]
  erb :'users/show'
end