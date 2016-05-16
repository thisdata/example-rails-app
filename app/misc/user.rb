# This is a plain old ruby object, which behaves like a regular User model
# might.
class User

  attr_accessor :id, :name, :email, :mobile, :balance

  def initialize(**args)
    args.each { |key, value| send "#{key}=", value }
    set_default_id_from_email
  end

  def display_name
    name || email
  end

  def as_json(**args)
    json = super(args)
    json
  end

  private
    def set_default_id_from_email
      # Use the email address as the ID of this fake user
      self.id ||= Digest::MD5.hexdigest(email)
    end

end