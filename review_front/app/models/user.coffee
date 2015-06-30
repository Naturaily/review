`import DS from 'ember-data'`

User = DS.Model.extend {
  image_url: DS.attr('string')
  name: DS.attr('string')
  nickname: DS.attr('string')
  admin: DS.attr('boolean')
  permissions: DS.hasMany('permission')
  person: DS.belongsTo('author')
  token: DS.attr('string')

  isAdmin: Ember.computed('admin', ->
    @get('admin') == true
  )
}

`export default User`
