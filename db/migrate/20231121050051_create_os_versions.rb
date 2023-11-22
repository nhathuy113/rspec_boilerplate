class CreateOsVersions < ActiveRecord::Migration[7.1]
  def change
    create_table :os_versions do |t|
      t.string :version

      t.timestamps
    end
  end
end
