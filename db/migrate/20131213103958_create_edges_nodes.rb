class CreateEdgesNodes < ActiveRecord::Migration
  def change
    create_table :edges_nodes, id: false do |t|
      t.references :node, index: true
      t.references :edge, index: true
    end
    add_index :edges_nodes, [:node_id, :edge_id]
  end
end
