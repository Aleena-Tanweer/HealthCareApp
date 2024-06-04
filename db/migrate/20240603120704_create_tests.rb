class CreateTests < ActiveRecord::Migration[7.1]
  def change
    create_table :tests do |t|
      t.references :order, null: false, foreign_key: true
      t.string :name
      t.text :description
      t.boolean :fasting_required
      t.string :status
      t.date :sample_collection_date
      t.date :sample_received_date
      t.string :result_document

      t.timestamps
    end
  end
end
