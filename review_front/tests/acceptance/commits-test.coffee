`import Ember from 'ember'`
`import { module, test } from 'qunit'`
`import startApp from '../helpers/start-app'`
`import Server from '../mocks/server'`

application = null
server = null

module 'Acceptance: ProjectCommits',
  beforeEach: ->
    application = startApp()
    server = Server.create()
    visit 'projects/1/commits'
    return

  afterEach: ->
    Ember.run application, 'destroy'
    server.shutdown()
    return

test 'goes to commits page', (assert) ->
  assert.equal currentPath(), "projects.project.commits"

test 'find pagination button', (assert) ->
  assert.ok find('.pagination')

test 'find correct page nameber', (assert) ->
  assert.ok find('.pagination .page-number:active')
  assert.ok find('.pagination a:contains("1")')
