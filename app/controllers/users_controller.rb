class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def downgrade
    @user = current_user
    @user.role = :standard
    @user.save!
    flash[:notice] = "Your membership has been downgraded."
    redirect_to wikis_path
  end
end
