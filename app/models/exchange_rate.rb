# frozen_string_literal: true

class ExchangeRate < ApplicationRecord
    validates :current_rate, presence: true, uniqueness: { 
        scope: [:current_rate, :parse_at]
    }

    validates :current_value, presence: true
    validates :parse_at, presence: true

    enum current_rate: {
        rub_usd: 'rub_usd',
        rub_eur: 'rub_eur',
        rub_cny: 'rub_cny'
    }
end
