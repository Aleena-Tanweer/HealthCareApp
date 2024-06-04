class CreatePatients < ActiveRecord::Migration[7.1]
  def change
    create_table :patients do |t|
      t.date :date_of_birth
      t.string :address
      t.string :contact_number
      t.boolean :fasting_requirements
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
