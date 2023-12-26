class ExchangeRateMapper
  def initialize(date_start, date_end)
    @scope = interval_rates(date_start, date_end)
    @dates = ['x']
    @rates = {
      rub_usd: ['RUB/USD'],
      rub_eur: ['RUB/EUR'],
      rub_cny: ['RUB/CNY']
    }.with_indifferent_access
  end

  def call
    return [] if @scope.blank?

    @scope.each do |record|
      @dates << record.parse_at.to_s
      @rates[record.current_rate] << record.current_value
    end

    @rates.values << @dates.uniq!
  end

  private

  def interval_rates(date_start, date_end)
    ExchangeRate.where('parse_at between ? and ?', date_start, date_end).order(parse_at: :asc)
  end
end
