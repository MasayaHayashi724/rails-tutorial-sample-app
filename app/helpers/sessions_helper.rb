module SessionsHelper

  # login with user
  def log_in(user)
    session[:user_id] = user.id
  end

  # remember user in eternal session
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # return currently logged in user if any
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # return true if logged in, false if not
  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

end
