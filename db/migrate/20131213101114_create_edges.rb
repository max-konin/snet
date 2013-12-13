class CreateEdges < ActiveRecord::Migration
  def change
    create_table :edges do |t|
      t.string :name
      t.references :data, polymorphic: true, index: true

      t.timestamps
    end
  end
end
