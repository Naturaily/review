class RemovingNotNullFromCommitFixesId < ActiveRecord::Migration
  def change
    change_column_null :commit_fixes, :fixing_commit_id, true 
  end
end
