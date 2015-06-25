`import DS from 'ember-data'`

Commit = DS.Model.extend
  remoteId: DS.attr('string')
  message: DS.attr('string')
  state: DS.attr('string')
  remoteUrl: DS.attr('string')
  project: DS.belongsTo('project')
  expiresAt: DS.attr('date')
  createdAt: DS.attr('date')
  authoredAt: DS.attr('date')
  author: DS.belongsTo('author')
  tickets: DS.hasMany('ticket')
  reviewer: DS.belongsTo('user', {async: true})
  fix: DS.hasMany('commit', {inverse: 'fix'})
  fixed: DS.hasMany('commit', {inverse: 'fixed'})

  shortHash: Ember.computed('remoteId', ->
    @get('remoteId').substr(0,6)
  )

  isRejected: Ember.computed('state', ->
    ['rejected', 'auto_rejected'].contains(@get('state'))
  )

  isPassed: Ember.computed('state', ->
    @get('state') == 'passed'
  )

  isFixed: Ember.computed('state', ->
    @get('state') == 'fixed'
  )

  isAccepted: Ember.computed('state', ->
    @get('state') == 'accepted'
  )

  belongsToMe: Ember.computed ->
    @store.find('user', 'me').get('person') is @get('author')

  hasReviewer: Ember.computed.notEmpty('reviewer.id')

`export default Commit`
