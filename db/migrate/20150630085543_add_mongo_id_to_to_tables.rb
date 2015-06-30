class AddMongoIdToToTables < ActiveRecord::Migration
  def change
    add_column :permissions, :mongo_id, :string
    add_column :projects, :mongo_id, :string
    add_column :tokens, :mongo_id, :string
    add_column :users, :mongo_id, :string
    add_column :people, :commit_mongo_id, :string #called as people table is propagated with data from commits MongoDB collection
    add_column :commits, :project_mongo_id, :string
    add_column :commits, :user_mongo_id, :string
    add_column :commits, :author_email, :string #exception, author email is kept to associate commit with person
    add_column :permissions, :old_level, :string #used to post import process permissions level
    add_column :permissions, :project_mongo_id, :string
    add_column :permissions, :user_mongo_id, :string
    add_column :tokens, :tokenable_mongo_id, :string
    change_column :commits, :message, :text #string is too short
    change_column :projects, :url, :string, null: true #some projects have empty url attributek
  end
end
