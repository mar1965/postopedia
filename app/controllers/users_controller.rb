class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @stripe_btn_data
  end

end
