desc 'Set default values to imported objects'
task set_trade_details: :environment do
  MigrationHelper.set_default_project_trade_details
end
task set_permissions: :environment do
  MigrationHelper.set_default_permissions
end
