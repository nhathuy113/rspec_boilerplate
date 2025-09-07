class CreateSmartphoneModelAndModelOptions < ActiveRecord::Migration[7.1]
  def change
    create_table :smartphone_models do |t|
      t.string :name
      t.references :year, null: false, foreign_key: true
      t.references :os_version, null: false, foreign_key: true
      t.references :brand, null: false, foreign_key: true

      t.timestamps
    end

    create_table :memories do |t|
      t.string :size

      t.timestamps
    end

    create_table :body_colors do |t|
      t.string :color

      t.timestamps
    end

    create_table :model_options do |t|
      t.references :smartphone_model, null: false, foreign_key: true
      t.references :body_color, null: false, foreign_key: true
      t.references :memory, null: false, foreign_key: true

      t.timestamps
    end
  end
end
