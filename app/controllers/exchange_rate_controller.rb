class ExchangeRateController < ApplicationController
  def index
    date_end = Date.current
    date_start = date_end - 1.month

    scope = ExchangeRate.where('parse_at between ? and ?', date_start, date_end).order(parse_at: :asc)
    
    @columns = ExchangeRateMapper.new(scope).call
  end
end