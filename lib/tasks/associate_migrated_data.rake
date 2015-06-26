desc "Set default values to imported objects"
task associate_commit_fixes: :environment do
  MigrationHelper.associate_commit_fixes
end
task associate_commits: :environment do
  MigrationHelper.associate_commits
end
task associate_permissions: :environment do
  MigrationHelper.associate_permissions
end
task associate_tokens: :environment do
  MigrationHelper.associate_tokens
end
task associate_users: :environment do
  MigrationHelper.associate_users
end
