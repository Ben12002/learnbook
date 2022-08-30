class UserMailer < ApplicationMailer

  def sign_up_email
    @user = params[:user]
    mail(to: @user.email, subject: 'Welcome to LearnBook')
  end
end
