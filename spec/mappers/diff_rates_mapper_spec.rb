require 'rails_helper'

describe DiffRatesMapper do
  context '.call' do

    subject do
      described_class.new.call
    end

    let!(:first_rate) do 
      create :exchange_rate, 
        current_rate: :rub_usd, 
        current_value: 300, 
        parse_at: Date.current.prev_week
    end

    let!(:second_rate) do 
      create :exchange_rate, 
        current_rate: :rub_usd, 
        current_value: 303, 
        parse_at: Date.current.prev_week.end_of_week
    end

    let(:rate_prev_week) { subject['USD'].last } 
    let(:rate_diff) { rate_prev_week[0] }
    let(:rate_diff_percent) { rate_prev_week[1].ceil }

    it do
      expect(rate_diff).to eq 3
      expect(rate_diff_percent).to eq 1
    end
  end
end