class HomeController < ApplicationController

  def index
  end

  def track
    # "Log the user in" (a.k.a. save the user details to the session)
    session["user"] = event_params["user"]
    session["user"]["balance"] = 10_000

    # Allow overriding of ip and user_agent
    session["current_ip"]         = event_params["ip"]          || request.remote_ip
    session["current_user_agent"] = event_params["user_agent"]  || request.user_agent

    # Track the event
    ThisData.track_login(
      ip: current_ip,
      user_agent: current_user_agent,
      user: current_user.as_json
    )

    redirect_to account_path, notice: "Welcome #{current_user.display_name}!"
  end

  def advanced
    @event = saved_event
  end

  def advanced_track
    # Create an Event from the params (handles giving the user an ID, etc)
    event = Event.new(event_params.deep_symbolize_keys)
    # Track the event
    ThisData.track(event.as_json)

    # Persist the event to the session, so we can repopulate the fields
    session[:event] = event.as_json
    redirect_to advanced_path, notice: "Tracked #{saved_event.user.display_name} #{event.verb}"
  end

  def logout
    session["user"] = nil
    redirect_to root_path, notice: "Good bye. Come back soon!"
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :mobile)
    end

    def event_params
      params.require(:event).permit(
        :verb,
        :ip,
        :user_agent,
        user: [
          :id,
          :email,
          :name,
          :mobile
        ]
      )
    end

    # So that performing multiple similar requests is easier, keep the
    # last event in the session so we can use it to repopulate the fields.
    def saved_event
      saved_event = session[:event].try(:deep_symbolize_keys) || {}
      @event = Event.new(saved_event)
    end
end
