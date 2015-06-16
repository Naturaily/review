`import { test, moduleForModel } from 'ember-qunit'`

moduleForModel 'commit', {
  # Specify the other units that are required for this test.
  needs: ['model:project', 'model:author', 'model:ticket', 'model:permission', 'model:user']
}

test 'it exists', (assert) ->
  model = @subject()
  #  store = @store()
  assert.ok !!model
