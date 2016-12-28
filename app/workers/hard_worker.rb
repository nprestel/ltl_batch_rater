class HardWorker
  include Sidekiq::Worker
  sidekiq_options retry: false
 end

=begin
  def perform(file_path)
    BatchRate.import_rates(file_path)
  end=end
