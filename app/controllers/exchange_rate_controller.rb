class ExchangeRateController < ApplicationController
  def index
    date_end = Date.current
    date_start = date_end - 1.month

    @columns = ExchangeRateMapper.new(date_start, date_end).call
  end

  def difference
    @diffs = DiffRatesMapper.new.call
  end
end