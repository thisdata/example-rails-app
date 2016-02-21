class HomeController < ApplicationController
  def index
  end

  def track
    # "Log the user in" (a.k.a. save the user details to the session)
    session["user"] = user_params

    # The magic!
    thisdata_track

    redirect_to root_path, notice: "Hi #{current_user.name}!"
    session["user"] = nil
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :mobile)
    end
end
