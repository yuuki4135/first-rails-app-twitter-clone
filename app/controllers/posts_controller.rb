class PostsController < ApplicationController
  
  def index
    @posts=Post.all.order(created_at: :desc)
  end
  
  def new
  end
  
  def show
    #@id=params[:id]
    @post=Post.find_by(id: params[:id])
  end
  
  def create
    params[:content]
    @post=Post.new(content: params[:content])
    @post.save
    if @post.save
      redirect_to("/posts/index")
      flash[:notice]="投稿しました"
    else
      render("/posts/new")
    end
  end
  
  def edit
    @post=Post.find_by(id: params[:id])
    
end

 def update
   @post=Post.find_by(id: params[:id])
   @post.content=params[:content]
   @post.save
   if @post.save 
   redirect_to("/posts/index")
   flash[:notice]="編集しました"
 else 
   #@post=Post.find_by(id: params[:id])
   #@post.content=params[:content]
   render("/posts/edit")
 end
 end
 
 def destroy
 @post=Post.find_by(id: params[:id])
 @post.destroy
 redirect_to("/posts/index")
 end
end
