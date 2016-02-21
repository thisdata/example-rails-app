# This is a plain old ruby object, which behaves like a regular User model
# might.
class User

  attr_accessor :id, :name, :email, :mobile

  def initialize(**args)
    args.each { |key, value| send "#{key}=", value }
  end

  def name
    @name || self.email
  end

end