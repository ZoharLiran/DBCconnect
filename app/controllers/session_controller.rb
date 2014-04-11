class SessionsController < ApplicationController
  def create
    puts "in sessions create, auth_hash is:"
    puts "#{auth_hash}"
    @user = User.find_or_create_from_auth_hash(auth_hash)
    self.current_user = @user
    redirect_to '/'
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

  def logout
    session.clear
    redirect_to root_path
  end
end