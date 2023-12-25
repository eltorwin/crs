class ExchangeRateMapper
  def initialize(scope)
    @scope = scope
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
end
