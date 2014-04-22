class AddStationsCapacityAndRegionsSubscribersCountToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :stations_capacity, :integer, null: false, default: 0
    add_column :jobs, :regions_subscribers_count, :integer, null: false, default: 0
  end
end
