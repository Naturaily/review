class AdjustPostgressTables < ActiveRecord::Migration
  def change
    change_column :commits, :message, :text #string is too short
    change_column :projects, :url, :string, null: true #some projects have empty url attribute
  end
end
