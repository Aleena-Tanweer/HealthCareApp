class AddLabToOrders < ActiveRecord::Migration[7.1]
  def change
    add_reference :orders, :lab, null: false, foreign_key: true
  end
end
