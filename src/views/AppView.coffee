class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .newGame-button':->
      #@model.newGame()
      @model.initialize()
      @render()
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      dealerHand = @model.get('dealerHand')
      playerHand = @model.get('playerHand')
      dealerScore = dealerHand.stand()
      playerScore = if playerHand.scores()[1] > 21 then playerHand.scores()[0] else playerHand.scores()[1]
      if dealerScore > 21
        alert 'Dealer busts, player wins!'
      else if playerScore>dealerScore and playerScore<=21
        alert 'player wins!'
      else if playerScore<dealerScore and dealerScore<=21
        alert 'dealer wins!'
      else 
        alert 'tie'
      console.log dealerScore
      console.log dealerHand.scores()
      #if @model.get('dealerHand') >= @model.get('playerHand')


  initialize: (params) ->
    @newGameButton = new NewGameView
    #@history = new GameHistView
    # @model.on 'gamechange', ->
    #   console.log 'init new game'
    #   @initialize()
    @history = params.history
    @history.collection = new Histories()
    @render()

  render: ->
    @$el.children().detach()
    @$el.prepend @newGameButton.render(), @template(), @history.render()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


