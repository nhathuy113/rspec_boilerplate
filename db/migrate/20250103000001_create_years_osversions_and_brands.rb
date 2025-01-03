class CreateYearsOsversionsAndBrands < ActiveRecord::Migration[7.1]
  def change
    create_table :years do |t|
      t.integer :number

      t.timestamps
    end

    create_table :brands do |t|
      t.string :name

      t.timestamps
    end

    create_table :os_versions do |t|
      t.string :version

      t.timestamps
    end
  end
end
