class CreateRegions < ActiveRecord::Migration
  def change
    create_table :regions do |t|
      t.references :job, index: true

      t.timestamps
    end
  end
end
