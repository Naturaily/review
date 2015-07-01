module Payloads
  class GithubHooksController < ActionController::Base
    before_filter :check_if_push_event

    expose(:parser) { GithubHookParser::Main.new request.raw_post }

    def create
      ProjectFromRepositoryParser.new(parser.repository).find_or_create
      CommitsFromCommitParsers.new(parser.commits).create
      render text: 'ok'
    end

    protected

    def check_if_push_event
      render text: 'ignored' if github_event_type != 'push'
    end

    def github_event_type
      request.headers.fetch('X-GitHub-Event')
    end
  end
end
