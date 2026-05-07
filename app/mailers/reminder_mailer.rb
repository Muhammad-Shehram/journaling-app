class ReminderMailer < ApplicationMailer
  def daily_reminder(user)
    @user            = user
    @default_journal = user.journals.find_by(is_default: true) ||
                       user.journals.order(updated_at: :desc).first
    mail(to: user.email, subject: "Time to reflect — your daily Reflekto reminder")
  end
end
