class CreateSmartphones < ActiveRecord::Migration[7.1]
  def change
    create_table :smartphones do |t|
      t.references :manufacturer, null: false, foreign_key: true
      t.references :smartphone_model, null: false, foreign_key: true
      t.references :memory, null: false, foreign_key: true
      t.references :year, null: false, foreign_key: true
      t.references :os_version, null: false, foreign_key: true
      t.references :body_color, null: false, foreign_key: true
      t.integer :price

      t.timestamps
    end
  end
end
