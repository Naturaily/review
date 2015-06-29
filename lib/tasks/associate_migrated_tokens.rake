desc "Migrates associated tokens"
task associate_tokens: :environment do
  MigrationHelper.associate_tokens
end

