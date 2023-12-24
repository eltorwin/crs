# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
    enum current_rate: {
        rub_usd: 'rub_usd',
        rub_eur: 'rub_eur',
        rub_cny: 'rub_cny'
    }
end
