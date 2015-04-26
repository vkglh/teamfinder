class AuthController < ApplicationController

  def signup
    user          = User.new
    user.email    = params[:form][:email]
    user.password = params[:form][:password]
    if user.save
      user.update_attribute :activation_state, 'active'
      auto_login user
      render json: { success: true }
    else
      render json: { success: false, message: user.errors.full_messages[0] }
    end
  end

  def signin
    login params[:form][:email], params[:form][:password]
    if current_user
      render json: { success: true }
    else
      render json: { success: false, message: 'Incorrect login' }
    end
  end

  def signout
    logout
    redirect_to '/'
  end

end
