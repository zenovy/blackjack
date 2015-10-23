class window.HandView extends Backbone.View
  className: 'hand'

  template: _.template '<h2><% if(isDealer){ %>Dealer<% }else{ %>You<% } %> (<span class="score"></span>)</h2>'

  initialize: ->
    @collection.on 'add remove change', => @render()
    #this.collection.on('add remove change', this.render, this)
    @render()

  render: ->
    @$el.children().detach()
    @$el.html @template @collection
    @$el.append @collection.map (card) ->
      new CardView(model: card).$el
    smallScore = @collection.scores()[0]
    largeScore = @collection.scores()[1]
    
    if (smallScore != largeScore && largeScore <= 21)
      @$('.score').text "#{smallScore} or #{largeScore}"
    else
      @$('.score').text "#{smallScore}"
    alert 'bust' if smallScore > 21

    #if (@collection.isDealer)



