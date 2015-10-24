class window.NewGameView extends Backbone.View
  tagName: 'button'

  className: 'newGame-button'

  initialize: ->
    @render()

  render: ->
    @$el.text 'NewGame'
