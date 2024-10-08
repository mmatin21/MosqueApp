class CreateBalances < ActiveRecord::Migration[7.0]
  def change
    create_table :balances do |t|
      t.date :balance_date
      t.decimal :amount
      t.references :masjid, null: false, foreign_key: true

      t.timestamps
    end
  end
end
