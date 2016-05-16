# This is a plain old ruby object, which helps us remember event details
# between page loads
class Event

  attr_accessor :verb, :ip, :user_agent, :user

  def initialize(**args)
    # Defaults
    self.verb ||= ThisData::Verbs::LOG_IN
    self.user ||= User.new(id: nil)

    # Assign attributes
    args.each { |key, value| send "#{key}=", value }

    # If user is defined as a Hash, make it a User object
    if self.user.is_a? Hash
      self.user = User.new(self.user)
    end

  end

end