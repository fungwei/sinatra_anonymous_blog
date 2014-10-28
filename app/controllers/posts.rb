get '/posts/create' do
  # Look in app/views/index.erb
  erb :'posts/create'
end

get '/posts/list' do
  @posts = Post.all
  # Look in app/views/index.erb
  erb :'posts/list'
end

get '/posts/view/:id' do
  # Look in app/views/index.erb
  @post = Post.find(params[:id])

  erb :'posts/view'
end

get '/posts/edit/:id' do
  @post = Post.find(params[:id])
  @tag_string = ""
  @post.tags.each do |tag|
    @tag_string += tag.name + ", "
  end
    @tag_string = @tag_string.gsub!(/, \z/,"")
  erb :'posts/edit'
end

post '/posts/edit/:id' do
  post = Post.find(params[:id])
  post.update(params[:post])


  post.tags.clear
  tags = params[:tags]
  tag_array = tags.split(/, |,/)

   tag_array.each do |tag|
    tag.downcase!
    tag.gsub!(" ","_")
    if !(Tag.exists?(name: tag))
      temp_tag = Tag.create(name: tag)
      post.tags << temp_tag
    else
      temp_tag = Tag.where(name: tag).first
      post.tags << temp_tag
    end
  end

  post.save

  redirect "/posts/view/#{params[:id]}"
end

post '/posts/create' do
  tags = params[:tags]
  tag_array = tags.split(/, |,/)
  temp_post = Post.create(params[:post])

  tag_array.each do |tag|
    tag.downcase!
    tag.gsub!(" ","_")
    if !(Tag.exists?(name: tag))
      temp_tag = Tag.create(name: tag)
      temp_post.tags << temp_tag
    else
      temp_tag = Tag.where(name: tag).first
      temp_post.tags << temp_tag
    end
  end
  redirect "posts/view/#{temp_post.id}"
end


delete '/posts/:id' do
  Post.find(params[:id]).destroy
  redirect '/posts/list'
end