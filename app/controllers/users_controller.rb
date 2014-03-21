class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    authorize! :index, @user, message: "Not authorized as an administrator"
    @users = User.all
  end

  def update
    authorize! :index, @user, message: "Not authorized as an administrator"
    @user = User.find(params[:id])
    role = Role.find(params[:user][:role_ids]) unless params[:user][:role_ids].nil?
    params[:user] = params[:user].except(:role_ids)
    if @user.update_attributes(secure_params)
      @user.update_plan(role) unless role.nil?
      redirect_to users_path, notice: "User updated"
    else
      redirect_to users_path, alert: "Unable to update user"
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