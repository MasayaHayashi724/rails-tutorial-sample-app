module SessionsHelper

  # login with user
  def log_in(user)
    session[:user_id] = user.id
  end
  
end
