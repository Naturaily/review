class RemoveRedundantColumns < ActiveRecord::Migration
  def change
    remove_column :commit_fixes, :fixes_mongo_id
    remove_column :commit_fixes, :fixed_mongo_id
    remove_column :commits, :project_mongo_id
    remove_column :commits, :user_mongo_id
    remove_column :commits, :author_email
    remove_column :people, :commit_mongo_id
    remove_column :permissions, :old_level
    remove_column :permissions, :project_mongo_id
    remove_column :permissions, :user_mongo_id
    remove_column :permissions, :mongo_id
    remove_column :projects, :mongo_id
    remove_column :tokens, :mongo_id
    remove_column :tokens, :tokenable_mongo_id
    remove_column :users, :mongo_id
  end
end
