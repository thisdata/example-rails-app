# This is a plain old ruby object, which helps us remember event details
# between page loads
class Event

  attr_accessor :verb, :ip, :user_agent, :user

  def initialize(**args)
    args.each { |key, value| send "#{key}=", value }

    # Set a blank user if undefined
    self.user ||= User.new(id: nil)
    # If user is defined as a Hash, make it a User object
    if self.user.is_a? Hash
      self.user = User.new(self.user)
    end

    self.verb = ThisData::Verbs::LOG_IN
  end

end