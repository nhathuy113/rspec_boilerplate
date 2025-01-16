class CreateSmartphoneAndSmartphoneOption < ActiveRecord::Migration[7.1]
  def change
    create_table :smartphones do |t|
      t.string :imei

      t.references :model_option, null: false, foreign_key: true
    end
  end
end
