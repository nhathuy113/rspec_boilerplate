class CreateBodyColors < ActiveRecord::Migration[7.1]
  def change
    create_table :body_colors do |t|
      t.string :color

      t.timestamps
    end
  end
end
