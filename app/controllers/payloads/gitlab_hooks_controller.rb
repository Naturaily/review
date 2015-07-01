module Payloads
  class GitlabHooksController < GithubHooksController
    protected

    def github_event_type
      params[:object_kind]
    end
  end
end
