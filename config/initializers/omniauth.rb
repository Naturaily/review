Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, AppConfig.github.appkey, AppConfig.github.secret
  provider :gitlab, AppConfig.gitlab.appkey, AppConfig.gitlab.secret, client_options: {
    site: ENV['GITLAB_SITE']
  }
end
