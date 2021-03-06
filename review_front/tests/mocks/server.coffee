`import Ember from 'ember'`
`import Pretender from 'pretender'`

Server = Ember.Object.extend
  init: ->
    @set('server', @_makePretender())

  shutdown: ->
    @get('server').shutdown()

  _makePretender: ->
    new Pretender ->
      @get '/api/v2/projects', ->
        [
          200, { "Content-type": "application/json" }, JSON.stringify( 
            projects: [ 
              { 
                id: 1
                accepted: 1
                rejected: 2
                pending: 6
                total: 10
                name: 'firstProject'
                grade: 'good'
                permission: [1]
              },{
                id: 2
                accepted: 0
                rejected: 2
                pending: 4 
                total: 10
                name: 'secondProject'
                grade: 'good'
                permission: [1]
              }
            ]
          ) 
        ]
      @get 'api/v2/users', ->
        [
          200, { "Content-type": "application/json" }, JSON.stringify(
            users:[
              {
                id: 1
                admin: true
                permissions: []
              },
              {
                id: 2
                admin: true
                permissions: []
              }
            ]
          )
        ]
      @get '/api/v2/users/me', ->
        [
          200, { "Content-type": "application/json" }, JSON.stringify(
            user:
              {
                id: 1
                admin: true
                permissions: []
              }
          )
        ]
      @get 'api/v2/permissions', ->
        [
          200, { "Content-type": "application/json"}, JSON.stringify(
            permissions: [
              {
                id: 1
                permissions:[1]
              }
            ]
          )
        ]
      @get '/api/v2/commits', ->
        [
          200, { "Content-type": "application/json" }, JSON.stringify(
            commits: [
              {
                id: 1
                project_id: 1
                author_id: 1
                state: "passed"
                tickets: []
              },
              {
                id: 2
                project_id: 2
                author_id: 1
              }
            ]
            authors: [
              {
                id: 1
                name: "John Doe"
              }
            ]
            meta: { total_pages: 1 }
          ) 
        ]
      @put '/api/v2/commits/2', ->
        [ 
          200, { "Content-type": "application/json" }, JSON.stringify(
            commit: {
              state: "accepted"
            }
          )
        ]
`export default Server`
