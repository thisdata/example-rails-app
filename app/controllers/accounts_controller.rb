class AccountsController < ApplicationController
  before_filter :require_current_user

  def show
  end

  def transfer
    if rand < 0.5
      redirect_to account_path, notice: "Your transfer was successful!"
      session["user"]["balance"] = 0
    else
      redirect_to account_path, error: "Sorry! This transfer has been blocked, pending review."
    end
  end

  private
    def require_current_user
      unless current_user
        redirect_to root_path, error: "Please log in"
      end
    end
end
