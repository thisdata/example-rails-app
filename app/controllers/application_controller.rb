class ApplicationController < ActionController::Base
  include ThisData::TrackRequest

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Usually current_user is a method which will return an authenticated user
  # record. In this demo, we're faking it out.
  def current_user
    return nil unless session["user"] && session["user"]["email"].present?

    User.new(
              # Use the email address as the ID of this fake user
      id:     Digest::SHA256.hexdigest(session["user"]["email"]),
      email:  session["user"]["email"],
      name:   session["user"]["name"],
      mobile: session["user"]["mobile"]
    )
  end
  helper_method :current_user

end
