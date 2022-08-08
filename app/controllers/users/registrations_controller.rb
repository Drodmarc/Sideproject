class Users::RegistrationsController < Devise::RegistrationsController
  def update
    user=params[:user]
    if user[:current_password].blank? && user[:password_confirmation].blank? && user[:password].blank?
      update_user
    else
      update_password
    end
  end

  private

  def update_password
    if @user.update_with_password(user_password_params)
      flash[:notice] = "Successfully Updated"
      sign_in @user, :bypass => true
      redirect_to users_profile_path
    else
      render :edit
    end
  end

  def update_user
    if @user.update(user_details_params)
      flash[:notice] = "Successfully Updated"
      sign_in @user, :bypass => true
      redirect_to users_profile_path
    else
      render :edit
    end
  end

  def user_details_params
    params.require(:user).permit(:phone, :image, :username)
  end

  def user_password_params
    params.require(:user).permit(:phone, :image, :username, :password, :password_confirmation, :current_password)
  end
end
