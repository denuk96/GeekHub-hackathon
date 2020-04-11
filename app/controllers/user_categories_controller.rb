class UserCategoriesController < ApplicationController
  before_action :set_user

  def edit; end

  def update
    if @user.update_attributes(user_params)
      redirect_to root_path
    else
      format.html { render :edit }
    end
  end

  private

  def set_user
    @user = User.find current_user.id
  end

  def user_params
    params.require(:user).permit(category_ids: [])
  end
end
