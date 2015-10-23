class window.AppView extends Backbone.View
  template: _.template '
    <button class="hit-button">Hit</button> <button class="stand-button">Stand</button>
    <div class="player-hand-container"></div>
    <div class="dealer-hand-container"></div>
  '

  events:
    'click .hit-button': -> @model.get('playerHand').hit()
    'click .stand-button': ->
      dealerHand = @model.get('dealerHand')
      playerHand = @model.get('playerHand')
      dealerHand.stand()
      dealerScore = if dealerHand.scores()[1] > 21 then dealerHand.scores()[0] else dealerHand.scores()[1]
      playerScore = if playerHand.scores()[1] > 21 then playerHand.scores()[0] else playerHand.scores()[1]
      if(playerScore>dealerScore)
        alert 'player wins!'
      else 
        alert 'dealer wins!'
      console.log dealerScore
      console.log dealerHand.scores()
      #if @model.get('dealerHand') >= @model.get('playerHand')


  initialize: ->
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template()
    @$('.player-hand-container').html new HandView(collection: @model.get 'playerHand').el
    @$('.dealer-hand-container').html new HandView(collection: @model.get 'dealerHand').el


