class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Reflekto — your journal is ready")
  end
end
