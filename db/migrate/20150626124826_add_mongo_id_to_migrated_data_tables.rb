class AddMongoIdToMigratedDataTables < ActiveRecord::Migration
  def change
    add_column :permissions, :mongo_id, :string
    add_column :projects, :mongo_id, :string
    add_column :tokens, :mongo_id, :string
    add_column :users, :mongo_id, :string
    add_column :commit_fixes, :fixes_mongo_id, :string #called to distinguish from fixing commit MongoDB _id
    add_column :people, :commit_mongo_id, :string #called as people table is propagated with data from commits MongoDB collection
  end
end
