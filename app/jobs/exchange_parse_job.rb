class ExchangeParseJob
  include Sidekiq::Job

  def perform(*args)
    Rails.logger.info("#{DateTime.now}: oo")
    CbrParseService.new.call
  end
end
