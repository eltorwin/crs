class ExchangeRateController < ApplicationController
  def index
    date_end = Date.current
    date_start = date_end - 1.month

    scope = interval_rates(date_start, date_end)

    @columns = ExchangeRateMapper.new(scope).call
  end

  def difference
    @diffs = DiffRatesMapper.new.call
  end

  private

  def interval_rates(date_start, date_end)
    ExchangeRate.where('parse_at between ? and ?', date_start, date_end).order(parse_at: :asc)
  end
end