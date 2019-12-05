class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.references :project, foreign_key: true
      t.string :number
      t.float :price, array: true, default: []
      t.string :name
      t.float :size
      t.text :description
      t.string :amenities, array: true, default: []
      t.json :pictures

      t.timestamps
    end
  end
end