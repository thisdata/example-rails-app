class AccountsController < ApplicationController
  before_filter :require_current_user

  def show
  end

  def transfer
  end

  private
    def require_current_user
      unless current_user
        flash[:error] = "Please log in"
        redirect_to root_path
      end
    end
end
