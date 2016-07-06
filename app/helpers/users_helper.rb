module UsersHelper
  def avatar_url(user)
    #user = User.find_by(email: params[:session][:email].downcase)
     gravatar_id = Digest::MD5::hexdigest(user.email).downcase
     "http://gravatar.com/avatar/#{gravatar_id}.png?s=48"
   end
end
