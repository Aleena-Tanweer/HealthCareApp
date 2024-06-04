class CreateLabs < ActiveRecord::Migration[7.1]
  def change
    create_table :labs do |t|
      t.string :name
      t.string :country_code, limit: 2

      t.timestamps
    end
  end
end
