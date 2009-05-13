class CreateCurrenciesQuotes < ActiveRecord::Migration
  def self.up
    create_table :currencies_quotes do |t|
      t.string :symbol
      t.date :found_date
      t.string :value

      t.timestamps
    end
  end

  def self.down
    drop_table :currencies_quotes
  end
end
