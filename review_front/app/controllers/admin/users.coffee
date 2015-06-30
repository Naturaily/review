`import Ember from 'ember'`

AdminUsersController = Ember.Controller.extend

  projects: Ember.computed.alias('model.projects')
  users: Ember.computed.alias('model.users')
  permissions: Ember.computed.alias('model.permissions')
  currentUserId: Ember.computed.alias('model.currentUserId')

  page: 1
  perPage: 25

`export default AdminUsersController`
