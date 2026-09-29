class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user
    mail(to: user.email, subject: "Welcome to Reflekto — your journal is ready")
  end

  def app_pause_notice(user)
    @user = user
    mail(to: user.email, subject: "Reflekto is pausing — please export your data by October 3")
  end
end
