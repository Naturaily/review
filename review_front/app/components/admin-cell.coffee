`import Ember from 'ember'`

AdminCell = Ember.Component.extend
  tagName: 'th'
  classNames: ['text-center']
  classNameBindings: ['user.isAdmin:danger:success']

  actions:
    setAdmin: (user)->
      user.set('admin', true).save()

    removeAdmin: (user, currentUserId)->
      user.set('admin', false).save() unless user.get('id') == currentUserId

`export default AdminCell`
