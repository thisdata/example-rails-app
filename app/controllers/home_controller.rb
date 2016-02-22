class HomeController < ApplicationController

  def index
  end

  def track
    # "Log the user in" (a.k.a. save the user details to the session)
    session["user"] = user_params

    # The magic!
    thisdata_track

    redirect_to root_path, notice: "Tracked #{current_user.display_name}"
    session["user"] = nil
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
    redirect_to advanced_path, notice: "Tracked #{saved_event.user.display_name}"
  end

  private

    def user_params
      params.require(:user).permit(:email, :name, :mobile)
    end

    def event_params
      params.require(:event).permit(
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
