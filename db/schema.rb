# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140205114109) do

  create_table "edges", force: true do |t|
    t.string   "name"
    t.integer  "data_id"
    t.string   "data_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "edges", ["data_id", "data_type"], name: "index_edges_on_data_id_and_data_type", using: :btree

  create_table "edges_graphs", id: false, force: true do |t|
    t.integer "graph_id"
    t.integer "edge_id"
  end

  add_index "edges_graphs", ["edge_id"], name: "index_edges_graphs_on_edge_id", using: :btree
  add_index "edges_graphs", ["graph_id", "edge_id"], name: "index_edges_graphs_on_graph_id_and_edge_id", using: :btree
  add_index "edges_graphs", ["graph_id"], name: "index_edges_graphs_on_graph_id", using: :btree

  create_table "edges_nodes", id: false, force: true do |t|
    t.integer "node_id"
    t.integer "edge_id"
  end

  add_index "edges_nodes", ["edge_id"], name: "index_edges_nodes_on_edge_id", using: :btree
  add_index "edges_nodes", ["node_id", "edge_id"], name: "index_edges_nodes_on_node_id_and_edge_id", using: :btree
  add_index "edges_nodes", ["node_id"], name: "index_edges_nodes_on_node_id", using: :btree

  create_table "graphs", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "graphs_nodes", id: false, force: true do |t|
    t.integer "graph_id"
    t.integer "node_id"
  end

  add_index "graphs_nodes", ["graph_id"], name: "index_graphs_nodes_on_graph_id", using: :btree
  add_index "graphs_nodes", ["node_id", "graph_id"], name: "index_graphs_nodes_on_node_id_and_graph_id", using: :btree
  add_index "graphs_nodes", ["node_id"], name: "index_graphs_nodes_on_node_id", using: :btree

  create_table "jobs", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "jobs", ["user_id"], name: "index_jobs_on_user_id", using: :btree

  create_table "nodes", force: true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "data_id"
    t.string   "data_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "nodes", ["data_id", "data_type"], name: "index_nodes_on_data_id_and_data_type", using: :btree

  create_table "points", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "region_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "points", ["region_id"], name: "index_points_on_region_id", using: :btree

  create_table "regions", force: true do |t|
    t.integer  "job_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "regions", ["job_id"], name: "index_regions_on_job_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
