class DailyMailer < ApplicationMailer
  def confirmation
    mail(:subject => "confirmation mail!", bcc: User.pluck(:email))
  end
end