class ChangeDataTypesForTransactionAmounts < ActiveRecord::Migration[6.1]
  def change
    change_column :transactions, :from_amount_cents, :bigint
    change_column :transactions, :to_amount_cents, :bigint
  end
end
