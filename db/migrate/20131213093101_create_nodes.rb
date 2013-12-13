class CreateNodes < ActiveRecord::Migration
  def change
    create_table :nodes do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.references :data, polymorphic: true, index: true

      t.timestamps
    end
  end
end
