class RemovingNotNullFromCommitFixes < ActiveRecord::Migration
  def change
    change_column_null :commit_fixes, :fixed_mongo_id, true
  end
end
