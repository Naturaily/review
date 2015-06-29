class AddCommitFixesForMongo < ActiveRecord::Migration
  def change
    add_column :commit_fixes, :fixed_mongo_id, :string
  end
end
