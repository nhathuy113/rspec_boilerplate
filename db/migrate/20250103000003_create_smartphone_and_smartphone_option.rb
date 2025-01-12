class CreateSmartphoneAndSmartphoneOption < ActiveRecord::Migration[7.1]
  def change
    create_table :smartphones do |t|
      t.string :imei

      t.references :smartphone_model, null: false, foreign_key: true
      t.references :model_option, null: false, foreign_key: true
    end

    # create_table :smartphone_options do |t|
    #   t.references :smartphone, null: false, foreign_key: true
    #   t.references :model_option, null: false, foreign_key: true
    #
    #   t.timestamps
    # end
  end
end
