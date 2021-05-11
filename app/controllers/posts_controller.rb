class PostsController < ApplicationController
  #function PostList
  #return all post
  def index
  	@posts = PostsService.listAll
    respond_to do |format|
      format.html
      format.csv { send_data @posts.to_csv, filename: "posts_#{Date.today}.csv" }
    end
  end

  #function post detail
  #params post id
  #return post
  def show
  	@post = PostsService.findPostById(params[:id])
	respond_to do |format|
	   	format.html
	    format.js
	end
  end

  #function new post
  #return post
  def new
  	@post = PostsService.newPost
  end

  #function create post form
  #params post params
  #return post create confirm 
  def create_form
    @post = Post.new(post_params)
    unless @post.valid?
      render :new
    else
      redirect_to :action => "create_confirm", title: @post.title, description: @post.description
    end
  end

  #function create post confirm
  #params post params
  #return create post
  def create_confirm
    @title = params[:title]
    @description = params[:description]
    @post = Post.new(title: @title, description: @description)
  end

  #function create post
  #params post params
  #return created post
  def create
  	savePost = PostsService.createPost(post_params)

  	if savePost
  		redirect_to posts_path
  	else
  		render :new
  	end
  end

  #function find edit post
  #params post id 
  #return post
  def edit
  	@post = PostsService.findPostById(params[:id])
  end

  #function post edit form
  #params post_params
  #return update_confirm post
  def edit_form
    @post = Post.new(post_params)
    unless @post.valid?
      render :new
    else
      redirect_to :action => "update_confirm", title: @post.title, description: @post.description, state: @post.status,id: @post.id
    end
  end

  #function post update confirm
  #params post params
  #rerurn update confirm post
  def update_confirm
    @id = params[:id]
    @title = params[:title]
    @description = params[:description]
    if params[:state] == ""  || params[:state] == "0"
  		@status = 0
  	else
  		@status = 1
  	end
    @post = Post.new(title: @title, description: @description, status: @status, id: @id)
  end

  #function post update
  #params post params
  #return updated post
  def post_update
  	updatePost = PostsService.updatePost(post_params)

  	if updatePost
  		redirect_to posts_path
  	else
  		render :edit
  	end 
  end

  #function post destroy
  #params post id
  def destroy
  	PostsService.destroyPost(params[:id])
  	redirect_to root_path
  end

  #function search post
  #params search key
  #return search post
  def search_post
    searchKey = params[:search]
    @posts = PostsService.searchPost(searchKey)
    render :index
  end

  #function post import
  #params post import file
  def import
  	Post.import(params[:file])
  	redirect_to root_url, notice: "Successfully Uploaded!!!"
  end

  private
    def post_params
    params.require(:post).permit(:id, :title, :description, :status)
  end
end