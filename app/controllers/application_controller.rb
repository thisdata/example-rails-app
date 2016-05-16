class ApplicationController < ActionController::Base
  # Adds thisdata_track as an instance method. It can hook in to requests
  # and track events
  include ThisData::TrackRequest
  add_flash_types :error

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # Usually current_user is a method which will return an authenticated user
  # record. In this demo, we're faking it out.
  def current_user
    return nil unless session["user"] && session["user"]["email"].present?

    User.new(
      email:  session["user"]["email"],
      name:   session["user"]["name"],
      mobile: session["user"]["mobile"],
      balance: session["user"]["balance"]
    )
  end
  helper_method :current_user

  def current_ip
    session["current_ip"] || request.remote_ip
  end
  helper_method :current_ip

  def current_user_agent
    session["current_user_agent"] || request.user_agent
  end
  helper_method :current_user_agent

end
