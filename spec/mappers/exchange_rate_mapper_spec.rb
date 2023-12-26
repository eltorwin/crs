require 'rails_helper'

describe ExchangeRateMapper do
  context '.call' do
    let(:date_start) { Date.parse('02-02-2022') }
    let(:date_end) { Date.parse('04-02-2022') }

    subject do
      described_class.new(date_start, date_end).call
    end

    let!(:first_rate) do 
      create :exchange_rate, current_rate: :rub_usd, current_value: 1, parse_at: Date.parse('03-02-2022')
    end

    let!(:second_rate) do 
      create :exchange_rate, current_rate: :rub_usd, current_value: 2, parse_at: Date.parse('05-02-2022')
    end

    let(:rub_usd_rates) { subject.first } 

    it do
      expect(rub_usd_rates[0]).to eq 'RUB/USD'
      expect(rub_usd_rates).to include(1)
      expect(rub_usd_rates).to_not include(2)
    end
  end
end