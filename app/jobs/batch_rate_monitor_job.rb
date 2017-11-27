require 'open-uri'

class BatchRateMonitorJob < ApplicationJob
  queue_as :default

  def perform(file_path, user_email)
  	csv_file = open(file_path,'rb:UTF-8')
    BatchRate.import_rates(csv_file)
    UserMailer.job_email(user_email).deliver_later
  end
end