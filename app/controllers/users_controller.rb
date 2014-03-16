class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    authorize! :index, @user, message: "Not authorized as an administrator"
    @users = User.all
  end

  def update
    authorize! :index, @user, message: "Not authorized as an administrator"
    user = User.find(params[:id])
    if user.update_attributes(secure_params)
      redirect_to users_path
    else
      redirect_to users_path
    end
  end


  def destroy
    authorize! :index, @user, message: "Not authorized as an administrator"
    user = User.find(params[:id])
    if (current_user == user)
      redirect_to users_path, error: "You cannot delete yourself"
    else
      user.delete
      redirect_to users_path, notice: "User deleted"
    end
  end
  private
    def secure_params
      if current_user && (current_user.has_role? :admin)
        params.require(:user).permit(:role_ids, :name, :email, :password, :password_confirmation, :remember_me)
      else
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :remember_me)
      end
    end
end