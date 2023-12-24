class CreateExchangeRates < ActiveRecord::Migration[7.1]
  def up
    create_enum :rate, %i[rub_usd rub_eur rub_cny]

    create_table :exchange_rates do |t|
      t.enum :current_rate, enum_type: :rate, default: :rub_usd, null: false
      t.decimal :current_value, null: false, default: 0, scale: 2, precision: 14
      t.date :parse_at
    end
  end

  def down
    execute <<-SQL
      DROP TYPE exchange_rate CASCADE;
    SQL

    drop_table :exchange_rates
  end
end
