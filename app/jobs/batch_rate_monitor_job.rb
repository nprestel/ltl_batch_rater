require 'open-uri'

class BatchRateMonitorJob < ApplicationJob
  queue_as :default

  def perform(file_path)
  	csv_file = open(file_path,'rb:UTF-8')
    BatchRate.import_rates(csv_file)
  end
end
