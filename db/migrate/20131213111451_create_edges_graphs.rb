class CreateEdgesGraphs < ActiveRecord::Migration
  def change
    create_table :edges_graphs, id: false do |t|
      t.references :graph, index: true
      t.references :edge, index: true
    end
    add_index :edges_graphs, [:graph_id, :edge_id]
  end
end
