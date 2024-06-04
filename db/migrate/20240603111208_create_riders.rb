class CreateRiders < ActiveRecord::Migration[7.1]
  def change
    create_table :riders do |t|
      t.string :vehicle_type
      t.string :area_of_coverage
      t.references :lab, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
