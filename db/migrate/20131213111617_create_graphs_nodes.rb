class CreateGraphsNodes < ActiveRecord::Migration
  def change
    create_table :graphs_nodes, id: false do |t|
      t.references :graph, index: true
      t.references :nodes, index: true
    end
    add_index :graphs_nodes, [:nodes_id, :graph_id]
  end
end
