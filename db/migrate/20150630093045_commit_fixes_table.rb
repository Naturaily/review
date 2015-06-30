class CommitFixesTable < ActiveRecord::Migration
  def change
    add_column :commit_fixes, :fixed_mongo_id, :string
    change_column_null :commit_fixes, :fixed_commit_id, true
  end
end
