`import Ember from 'ember'`

LogoutButton = Ember.Component.extend
  tagName: 'button'
  classNames: 'btn btn-danger navbar-btn'
  click: ->
    $.post '/auth/signout', _method: 'delete', (data, status, xhr)->
      location = xhr.getResponseHeader('Location')
      window.location = location


`export default LogoutButton`
