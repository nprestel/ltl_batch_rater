include Rails.application.routes.url_helpers

class UserMailer < ApplicationMailer
  default from: 'nick.prestel@gmail.com'

  def job_email(email_address)
    @email_to  = email_address
    @url  = batch_rates_url(format: "csv")
    mail(to: @email_to, subject: 'Link to your LTL batch rate results')
  end

end
