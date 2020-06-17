class UsersController < ApplicationController



  def index
    @users=User.all
  end
  
  def show
   #@id=params[:id] 
   @user=User.find_by(id: params[:id])
end

def signup
@user=User.new
end

def create
@user=User.new(name: params[:name],email: params[:email], password: params[:password], image_name:"default_user.jpg")
@user.save
if @user.save
    session[:user_id]=@user.id
    redirect_to("/users/index")
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
 else
render("/users/edit")
 end
 @user.save
 if @user.save
     flash[:notice]="編集しました"
     redirect_to("/users/index")
else
    render("/users/edit")
end
end

def destroy
    @user=User.find_by(id: params[:id])
    @user.destroy
    redirect_to("/users/index")
    flash[:notice]="削除しました"
end

def login_form
    @user=User.new
end


def login
    @user=User.find_by(email: params[:email],password: params[:password])
    if @user
    session[:user_id]=@user.id
    flash[:notice]="ログインしました"
    redirect_to("/posts/index")
    else
    @error_message = "メールアドレスまたはパスワードが間違っています。"
    @email=params[:email]
    @password=params[:password]
    render("/users/login_form")
end
end

   def logout
       session[:user_id]=nil
       flash[:notice]="ログアウトしました"
       redirect_to("/users/login")
   end


end
