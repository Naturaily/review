desc "Migrates uesers associations"
task associate_users: :environment do
  MigrationHelper.associate_users
end
