class RemovingNotNullFromFixedCommitId < ActiveRecord::Migration
  def change
    change_column_null :commit_fixes, :fixed_commit_id, true
  end
end
