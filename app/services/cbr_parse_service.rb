require 'open-uri'

class CbrParseService
  include ActionView::Helpers::NumberHelper

  EXTERNAL_API_URL = 'http://www.cbr.ru/scripts/XML_daily.asp'.freeze
  RATES = {
    rub_usd: 'USD', 
    rub_eur: 'EUR',
    rub_cny: 'CNY'
  }.freeze


  def initialize(date = Date.current)
    @date = date
    @date_to_params = date.strftime('%d.%m.%Y')
  end

  def call
    RATES.each do |enum_name, rate_name|
      value = find_value(rate_name)

      ExchangeRate.create(
        current_rate: enum_name,
        current_value: value_to_decimal(value),
        parse_at: @date
      )
    end
  end

  private

  def document
    url = "#{EXTERNAL_API_URL}?date_req=#{@date_to_params}"
    @document ||= Nokogiri::XML(URI.open(url))
  rescue StandardError => e
    Rails.logger.warn(e.message)
  end

  def find_value(rate_name)
    xpath = "//ValCurs/Valute/CharCode[contains(text(),'#{rate_name}')]/parent::Valute/Value"
    value = document.xpath(xpath).text || ''

    Rails.logger.warn("#{self.class.name}: rate value blank") if value.blank?
    
    value
  end

  def value_to_decimal(value)
    number_with_precision(value.gsub(',', '.'), precision: 2)
  end
end
