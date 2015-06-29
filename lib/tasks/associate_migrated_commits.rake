desc "Set default values to imported objects"
task associate_commits: :environment do
  MigrationHelper.associate_commits
end

