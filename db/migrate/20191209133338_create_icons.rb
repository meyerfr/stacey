class CreateIcons < ActiveRecord::Migration[5.2]
  def change
    create_table :icons do |t|
      t.string :icon_text
      t.references :amenity, foreign_key: true

      t.timestamps
    end
  end
end
