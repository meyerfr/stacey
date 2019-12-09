class CreateAmenities < ActiveRecord::Migration[5.2]
  def change
    create_table :amenities do |t|
      t.references :room, foreign_key: true
      t.references :project, foreign_key: true
      t.string :title

      t.timestamps
    end
  end
end
