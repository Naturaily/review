`import Ember from 'ember'`

NavLinks = Ember.Component.extend
  tagName: "ul"
  classNames: "nav navbar-nav navbar-left"
  classNameBindings: "active"
  active: Ember.computed.alias("childViews.firstObject.active")

`export default NavLinks `
