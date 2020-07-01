class UsersController < ApplicationController
before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}
before_action :forbid_login_user, {only: [:signup, :login, :create]}
  def index
    @users=User.all
  end
  
  def show
   #@id=params[:id] 
   @user=User.find_by(id: session[:user_id])
end

def signup
@user=User.new
end

def create
@user=User.new(name: params[:name],email: params[:email], password: params[:password], image_name: "default_user.jpg")
@user.save
if @user.save
    session[:user_id]=@user.id
    flash[:notice] = "ユーザー作成、ログインしました"
    redirect_to("/users/#{@user.id}")
else
    render("/users/signup")
end
end

def edit
@user=User.find_by(id: params[:id])
end

def update
 @user=User.find_by(id: params[:id])
 @user.name=params[:name]
 @user.email=params[:email]
 if params[:image]
 @user.image_name="#{@user.id}.jpg"
 image=params[:image]
 File.binwrite("public/user_images/#{@user.image_name}",image.read)
 @user.save
if @user.save
     flash[:notice]="編集しました"
     redirect_to("/users/#{@user.id}")
else
    render("/users/edit")
end

else
　@user.save
if @user.save
     flash[:notice]="編集しました"
     redirect_to("/users/#{@user.id}")
else
    render("/users/edit")
 end
end
end

def destroy
    @user=User.find_by(id: params[:id])
    @user.destroy
    @posts=Post.where(user_id: @user.id)
    @posts.each do|post|
    post.destroy
end
    @likes=Like.where(user_id: @user.id)
    @likes.each do|like|
    like.destroy
end
    session[:user_id]=nil
    flash[:notice]="削除しました、もう一度新規登録、ログインしてください"
    redirect_to("/users/signup")
    
end

def login_form
    @user=User.new
end


def login
    @user=User.find_by(email: params[:email])
     if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] ="ログインしました"
      redirect_to("/users/#{@user.id}")
    else
      @error_message = "メールアドレスまたはパスワードが間違っています"
      @email = params[:email]
      @password = params[:password]
      render("/users/login_form")
    end
  end

   def logout
       session[:user_id]=nil
       flash[:notice]="ログアウトしました"
       redirect_to("/users/login")
   end


def ensure_correct_user
    if @current_user.id != params[:id].to_i
        flash[:notice]="認証できません"
        redirect_to("users/index")
end
end

def like
    @user=User.find_by(id: params[:id])
    @likes=Like.where(user_id: @user.id)
end


end
