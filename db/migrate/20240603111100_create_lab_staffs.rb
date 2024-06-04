class CreateLabStaffs < ActiveRecord::Migration[7.1]
  def change
    create_table :lab_staffs do |t|
      t.string :department
      t.references :lab, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
