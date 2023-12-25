class DiffRatesMapper
  def call
    map = {}

    CbrParseService::RATES.each do |enum_name, rate_name|
      map[rate_name] = diffs_for_enum(enum_name)
    end

    map
  end

  private

  def diffs_for_enum(enum_name)
    diffs = []

    date = Date.current
    (1..4).each do |offset|
      date = date.prev_week

      scope = ExchangeRate.where(
        'current_rate = ? and parse_at between ? and ?', 
        enum_name, 
        date, 
        date.end_of_week
      ).to_a

      diffs << prepare_diff_data(
        scope.first.current_value, # start week value
        scope.last.current_value # end week value
      )
    end

    diffs.reverse
  end

  def percentage_off(original_deal, our_deal)
    (Float(original_deal - our_deal) / original_deal * 100)
  end

  def prepare_diff_data(first_value, last_value)
    [
      last_value - first_value, # diff quantity
      percentage_off(last_value, first_value) # diff percentage
    ]
  end
end