class SessionsController < ApplicationController
  def create
    @user = User.find_by(email: user_params[:email])
    @user ||= User.create(user_params)
    if @user.valid? && @user&.authenticate(user_params[:password])
       @user.update(name: user_params[:name]) if user_params[:name].present?
      cookies.signed[:user] = @user.id
      redirect_to chat_path, notice: 'Cool! You\'re Logged in'
    else
      redirect_to root_path, notice: @user.errors.full_messages.to_sentence
    end
  end

  def destroy
    cookies.delete :user
    redirect_to :root, notice: 'You\'re logged out'
  end

  private

  def user_params
    params.require(:user).permit(:email, :name, :password)
  end
end
