class CreateDoctors < ActiveRecord::Migration[7.1]
  def change
    create_table :doctors do |t|
      t.string :specialization
      t.string :clinic_hospital_name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
