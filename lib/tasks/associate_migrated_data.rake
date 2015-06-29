desc "Set default values to imported objects"
task associate_commit_fixes: :environment do
  MigrationHelper.associate_commit_fixes
end
