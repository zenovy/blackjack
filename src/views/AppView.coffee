class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .newGame-button':->
      @model.initialize()
      @render()
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      $('.stand-button').hide()
      $('.hit-button').hide()
      dealerHand = @model.get('dealerHand')
      playerHand = @model.get('playerHand')
      dealerScore = dealerHand.stand()
      playerScore = if playerHand.scores()[1] > 21 then playerHand.scores()[0] else playerHand.scores()[1]
      if dealerScore > 21
        $('.history').prepend('<div>Dealer busts, player wins!</div>');
        @cash.endGame(true)
      else if playerScore>dealerScore and playerScore<=21
        $('.history').prepend('<div>Player wins!</div>');
        @cash.endGame(true)
      else if playerScore<dealerScore and dealerScore<=21
        $('.history').prepend('<div>Dealer wins!</div>');
        @cash.endGame(false)
      else 
        $('.history').prepend('<div>Tie!</div>');
      

  initialize: (params) ->
    @newGameButton = new NewGameView
    @history = params.history
    @history.collection = new Histories()
    @cash = new PlayerCash
    @playerCashView = new PlayerCashView {model:@cash}
    @render()

  render: ->
    @$el.children().detach()
    @$el.prepend @newGameButton.render(), @playerCashView.render(), @template(), '<h2>Game History</h2>', @history.render()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


