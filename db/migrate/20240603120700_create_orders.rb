class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.string :status
      t.date :order_date
      t.string :order_barcode

      t.timestamps
    end
  end
end
