class PostsController < ApplicationController
  before_action :authenticate_user, {only: [:index, :new, :show, :create]}
  before_action :ensure_correct_user, {only: [:edit,:update, :destroy]}
  
  def index
    @posts=Post.all.order(created_at: :desc)
  end
  
  def new
      @post=Post.new
  end
  
  def show
    #@id=params[:id]
    @post=Post.find_by(id: params[:id])
    @user=@post.user
    @like_count=Like.where(post_id: @post.id).count
  end
  
  def create
    params[:content]
    @post=Post.new(content: params[:content], user_id: @current_user.id)
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
   render("/posts/edit")
 end
 end
 
 def destroy
 @post=Post.find_by(id: params[:id])
 @post.destroy
 flash[:notice]="削除しました"
 redirect_to("/posts/index")
 end
 
 def ensure_correct_user
   @post=Post.find_by(id:params[:id])
  if @post.user_id != @current_user.id
    flash[:notice]="権限がありません"
    redirect_to("/posts/index")
end
 end
end
