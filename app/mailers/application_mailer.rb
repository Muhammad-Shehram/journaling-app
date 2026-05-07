class ApplicationMailer < ActionMailer::Base
  default from: ENV.fetch("MAILER_FROM", "Reflekto <hello@reflektoapp.com>")
  layout "mailer"
end
