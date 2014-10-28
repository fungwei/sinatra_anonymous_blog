get '/' do
  # Look in app/views/index.erb
  redirect "/posts/list"
end

post '/test' do
  erb :test
end