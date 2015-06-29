lock '3.2.1'

set :application, "review"
set :repo_url,  "git@github.com:netguru/review.git"
set :deploy_to, ENV['DEPLOY_PATH']

set :linked_files, %w(config/database.yml config/sec_config.yml config/nginx.production.review.conf)
set :linked_dirs, %w(log tmp vendor/bundle public/uploads review_front/bower_components review_front/node_modules)

set :npm_target_path, -> { release_path.join('review_front') }
set :bower_target_path, -> { release_path.join('review_front') }
set :ember_cli_target_path, -> { release_path.join('review_front') }
