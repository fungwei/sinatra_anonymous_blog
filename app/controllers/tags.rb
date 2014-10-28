get '/tags/:name' do
  @tag_name = params[:name]
  @tag_name.downcase!
  @tag_name.gsub!(" ","_")

  @posts = Tag.find_by(name: @tag_name).posts



  erb :'tags/list'
end

get '/tags/' do
  tags = Tag.all
  @tags_sorted = tags.sort{ |a, b| a.name <=> b.name }
  # Look in app/views/index.erb
  erb :'tags/index'
end