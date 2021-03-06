class App.Collections.Items extends Backbone.Collection
  initialize: ->
    socket = io.connect()
    socket.on 'new-item', (data) =>
      this.add new App.Models.Item
        title: data.title
        image: data.image
        description: data.description
        category: data.category
        body: data.body
        metadata: data.metadata
        url: data.url

    this.details_view = new App.Views.Details
      el: $(".details")
      collection: this


class App.Models.Item extends Backbone.Model
  initialize: ->
    this.view = new App.Views.Item model: this
    true


class App.Views.Item extends Backbone.View
  tagName: 'li'

  events:
    'click': -> App.router.navigate "item/#{this.model.cid}", trigger: true

  initialize: ->
    this.render()

  render: ->
    this.$el.addClass this.model.get('category')
    this.$el.html _.template $("#item-view").html(), this.model.toJSON()
    $("ul").prepend this.el
    curHeight = this.$el.height()
    this.$el.addClass "close"
    setTimeout ()=>
      this.$el.removeClass "close"
      this.$el.addClass "open"
      this.$el.css { height: curHeight }
    , 500


class App.Views.Details extends Backbone.View
  template: ->
    _.template($('#details-view').html(), this.model.toJSON())

  events:
    'click .back': -> App.router.navigate "/", trigger: true
  
  initialize: (opts) ->
    this.collection = opts.collection

  render: (cid) ->
    this.model = this.collection.get(cid)
    if this.model?
      this.$el.find(".info").html(this.template())
    else
      this.$el.find(".info").html "<h3><em>Sorry, nothing to see here!</em></h3>"
    
