class AddAssociationsMongoId < ActiveRecord::Migration
  def change
    add_column :commits, :project_mongo_id, :string
    add_column :commits, :user_mongo_id, :string
    add_column :commits, :author_email, :string #exception, author email is kept to associate commit with person
    add_column :permissions, :old_level, :string #used to post import process permissions level
    add_column :permissions, :project_mongo_id, :string
    add_column :permissions, :user_mongo_id, :string
    add_column :tokens, :tokenable_mongo_id, :string
  end
end
