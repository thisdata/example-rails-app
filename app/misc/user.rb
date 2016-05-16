# This is a plain old ruby object, which behaves like a regular User model
# might.
class User

  attr_accessor :id, :name, :email, :mobile, :balance

  def initialize(**args)
    args.each { |key, value| send "#{key}=", value }
  end

  def display_name
    name || email
  end

  def as_json(**args)
    json = super(args)
    # Use the email address as the ID of this fake user
    json[:id] ||= Digest::MD5.hexdigest(email)
    json
  end

end