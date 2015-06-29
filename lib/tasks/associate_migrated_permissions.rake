desc "Migrates permission associations"
task associate_permissions: :environment do
  Migrationhelper.associate_permissions
end

