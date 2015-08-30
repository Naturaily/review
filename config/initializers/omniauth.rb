Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, AppConfig.github.appkey, AppConfig.github.secret
  provider :bitbucket, AppConfig.bitbucket.appkey, AppConfig.bitbucket.secret
  provider :gitlab, AppConfig.gitlab.appkey, AppConfig.gitlab.secret, client_options: {
    site: AppConfig.gitlab.site
  }
end
