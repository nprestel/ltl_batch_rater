class BatchRateMonitorJob < ApplicationJob
  queue_as :default

  def perform(file_path)
    BatchRate.import_rates(file_path)
  end
end


